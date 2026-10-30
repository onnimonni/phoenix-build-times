{ pkgs, config, ... }:

# Erlang/OTP and Elixir are built from the ORIGINAL upstream repositories at a
# pinned commit, plus the patches in ./patches. Every patch is listed below with
# what it does, why, and its upstream status. Remove a patch from a list to
# measure without it.
#
# Bump upstream:
#   gh api repos/erlang/otp/commits/master --jq .sha
#   gh api repos/elixir-lang/elixir/commits/main --jq .sha
#   nix flake prefetch --json github:erlang/otp/<sha> | jq -r .hash
# then check the patches still apply: git am patches/<project>/*.patch
let
  otpPatches = [
    # beam_types:norm_number/1 crashed (badarg in float/1) on integer ranges
    # beyond the float range, e.g. guards comparing against 10^2000 in the
    # `decimal` library: OTP master could not compile Ecto apps.
    # Upstream: https://github.com/erlang/otp/pull/12121 (open)
    ./patches/otp/0001-compiler-Don-t-crash-on-number-ranges-beyond-the-float-range.patch
  ];

  elixirPatches = [
    # Type check cache: when a recompiled module's ExCk chunk (exports,
    # signatures, deprecations) is unchanged, runtime dependents without
    # warnings reuse their previous type check result. Behaviour checks and
    # @after_verify (e.g. ~p route checks) always run. Editing a LiveView no
    # longer re-type-checks the router: hot reload 130 -> 84ms.
    # Upstream: not submitted (fork: onnimonni/elixir@faster-recompile)
    ./patches/elixir/0001-Reuse-type-check-results-of-dependents-when-signatur.patch

    # Extends 0001 to dependents WITH type warnings: type diagnostics are stored
    # per module in the manifest (vsn 41) separately from @after_verify ones and
    # replayed byte-identically. Router with a warning: LiveView edit 0.45 -> 0.39s.
    # Upstream: not submitted
    ./patches/elixir/0002-Reuse-type-check-results-of-dependents-with-warnings.patch

    # Caches converged Hex/git dependencies in _build/<env>/.mix/deps_cache
    # (keyed on lock, root deps, env, target, versions, git deps' mix.exs) and
    # reads git dep revisions from .git instead of running `git`. No-op
    # `mix compile` 0.34 -> 0.23s. Opt out: MIX_DEPS_CACHE=0.
    # Upstream: not submitted (needs discussion)
    ./patches/elixir/0003-Cache-converged-dependencies-on-disk-read-git-depend.patch

    # Stores after_verify in ExCk so dependents that are not type checked read
    # only ExCk + Attr chunks instead of decoding their whole debug info.
    # Editing core_components: decode CPU 39 -> 4ms.
    # Upstream: not submitted (prototype; checker version not bumped)
    ./patches/elixir/0004-Skip-debug-info-decoding-for-dependents-that-are-not.patch
  ];

  erlangMain = pkgs.beam.interpreters.erlang_28.overrideAttrs (old: {
    # OTP master reports itself as 30; the label stays <= 29 because nixpkgs'
    # Elixir derivation only accepts OTP 27..29
    version = "29.0-master-4ba5448-patched";
    src = pkgs.fetchFromGitHub {
      owner = "erlang";
      repo = "otp";
      rev = "4ba5448abb5a771c7b7bd336a8054bdfdc3a29eb";
      hash = "sha256-MQtOjvYJ6vYzsbx4iBIJ2lP6dazgW5jCLvOOFDKxv1A=";
    };
    patches = (old.patches or [ ]) ++ otpPatches;
  });

  beamMain = pkgs.beam28Packages.overrideScope (_: _: { erlang = erlangMain; });

  elixirMain = beamMain.elixir_1_20.overrideAttrs (old: {
    version = "1.21.0-main-669f848-patched";
    src = pkgs.fetchFromGitHub {
      owner = "elixir-lang";
      repo = "elixir";
      rev = "669f8481992a14820cd155d291aded6d41994b54";
      hash = "sha256-Sc1iI6Ga72gqm3LAB/hUaJXHGefSg+2ASr4e3u3XmR4=";
    };
    patches = (old.patches or [ ]) ++ elixirPatches;
  });
in
{
  languages.elixir = {
    enable = true;
    package = elixirMain;
  };

  packages = [
    erlangMain
    pkgs.hyperfine
  ];

  # Compile dependencies in 4 OS processes in parallel (Elixir 1.19+).
  env.MIX_OS_DEPS_COMPILE_PARTITION_COUNT = "4";

  # Skip the Erlang compiler's optimization passes for everything compiled in
  # this shell, dependencies included: ~70% faster dev builds. shop/mix.exs
  # refuses to build MIX_ENV=prod with these set.
  env.ERL_COMPILER_OPTIONS = "[no_ssa_opt,no_copt,no_bsm_opt,no_bool_opt,no_share_opt,no_recv_opt,no_throw_opt]";

  env.MIX_HOME = "${config.env.DEVENV_STATE}/mix";
  env.HEX_HOME = "${config.env.DEVENV_STATE}/hex";

  git-hooks.hooks.mix-format = {
    enable = true;
    excludes = [ "^bench/" ];
  };
}
