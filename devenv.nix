{ pkgs, config, ... }:

let
  # Latest Erlang/OTP master and Elixir main, built from source.
  # Bump: gh api repos/erlang/otp/commits/master --jq .sha
  #       nix flake prefetch github:erlang/otp/<sha>
  erlangMain = pkgs.beam.interpreters.erlang_28.overrideAttrs (_: {
    # OTP master reports itself as 30; the label stays <= 29 because nixpkgs'
    # Elixir derivation only accepts OTP 27..29
    version = "29.0-master-4ba5448";
    src = pkgs.fetchFromGitHub {
      owner = "erlang";
      repo = "otp";
      rev = "4ba5448abb5a771c7b7bd336a8054bdfdc3a29eb";
      hash = "sha256-MQtOjvYJ6vYzsbx4iBIJ2lP6dazgW5jCLvOOFDKxv1A=";
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

  env.MIX_HOME = "${config.env.DEVENV_STATE}/mix";
  env.HEX_HOME = "${config.env.DEVENV_STATE}/hex";

  git-hooks.hooks.mix-format = {
    enable = true;
    excludes = [ "^bench/" ];
  };
}
