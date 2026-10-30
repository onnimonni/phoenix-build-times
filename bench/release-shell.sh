#!/usr/bin/env bash
# Runs a command with the latest *released* toolchain (Elixir 1.19 / OTP 28),
# for comparing against the main-branch devenv: bench/release-shell.sh 'mix compile'
set -euo pipefail
nixpkgs=github:cachix/devenv-nixpkgs/rolling
export MIX_HOME="$PWD/.devenv/state/mix-release" HEX_HOME="$PWD/.devenv/state/hex-release"
exec nix shell "$nixpkgs#beam28Packages.elixir_1_19" "$nixpkgs#beam28Packages.erlang" "$nixpkgs#hyperfine" -c bash -c "mix local.hex --force --if-missing >/dev/null; mix local.rebar --force --if-missing >/dev/null; mix archive.install hex phx_new --force >/dev/null 2>&1; $*"
