{ pkgs, config, ... }:

let
  # Latest Erlang/OTP master and Elixir main, built from source.
  # Bump: gh api repos/erlang/otp/commits/master --jq .sha
  #       nix flake prefetch github:erlang/otp/<sha>
  erlangMain = pkgs.beam.interpreters.erlang_28.overrideAttrs (_: {
    # OTP master reports itself as 30; the label stays <= 29 because nixpkgs'
    # Elixir derivation only accepts OTP 27..29
    version = "29.0-master-4ba5448-fix";
    src = pkgs.fetchFromGitHub {
      # erlang/otp master 4ba5448 + fix for a compiler crash on huge integer
      # ranges: github.com/onnimonni/otp/tree/fix-norm-number-bigint
      owner = "onnimonni";
      repo = "otp";
      rev = "6b1f22712be9823923f6eea827a92211ea84fa9a";
      hash = "sha256-m0cpv37b5iu0NnGBCLU88Rvl9Hpt+Psjro1Uy/UFFN8=";
    };
  });

  beamMain = pkgs.beam28Packages.overrideScope (_: _: { erlang = erlangMain; });

  elixirMain = beamMain.elixir_1_20.overrideAttrs (_: {
    version = "1.21.0-main-669f848";
    src = pkgs.fetchFromGitHub {
      owner = "elixir-lang";
      repo = "elixir";
      rev = "669f8481992a14820cd155d291aded6d41994b54";
      hash = "sha256-Sc1iI6Ga72gqm3LAB/hUaJXHGefSg+2ASr4e3u3XmR4=";
    };
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

  env.MIX_HOME ="${config.env.DEVENV_STATE}/mix";
  env.HEX_HOME = "${config.env.DEVENV_STATE}/hex";

  git-hooks.hooks.mix-format = {
    enable = true;
    excludes = [ "^bench/" ];
  };
}
