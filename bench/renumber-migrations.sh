#!/usr/bin/env bash
# phx.gen.* run in a loop creates migrations with the same timestamp; give them
# unique, ordered versions.  bench/renumber-migrations.sh APP_DIR
set -euo pipefail
cd "$1/priv/repo/migrations"
version=20260101000000
for file in $(ls *.exs | sort); do
  version=$((version + 1))
  mv "$file" "${version}_${file#*_}"
done
