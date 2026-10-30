#!/usr/bin/env bash
# Measures compile times of a Phoenix app with the current toolchain.
#   bench/measure.sh APP_DIR [RUNS]
# Prints a markdown table row per scenario: median of RUNS (default 5) with
# hyperfine, plus how many modules each incremental edit recompiles.
set -euo pipefail
APP=$(cd "$1" && pwd)
RUNS=${2:-5}
cd "$APP"
export MIX_ENV=${MIX_ENV:-dev}

app=$(mix run --no-start --no-compile -e 'IO.write(Mix.Project.config()[:app])' 2>/dev/null || basename "$APP")
web="lib/${app}_web"

median() { # hyperfine JSON -> median seconds
  perl -MJSON::PP -e 'local $/; my $r = decode_json(<STDIN>)->{results}[0]; my @t = sort { $a <=> $b } map { $_->{time_wall_clock}{value} // $_ } @{ $r->{measurements} || $r->{times} }; printf "%.2f", $t[int(@t / 2)]'
}

run() { # run NAME PREPARE COMMAND
  local name=$1 prepare=$2 command=$3
  hyperfine --runs "$RUNS" --warmup 0 --prepare "$prepare" --export-json /tmp/hf.json "$command" >/dev/null 2>&1 ||
    { echo "| $name | FAILED |"; return; }
  local count="-"
  if [ -n "${4:-}" ]; then
    eval "$prepare" >/dev/null 2>&1
    count=$(mix compile --verbose 2>&1 | grep -c '^Compiled' || true)
  fi
  echo "| $name | $(median </tmp/hf.json)s | $count |"
}

mix deps.get >/dev/null
echo "| scenario | median | modules recompiled |"
echo "|---|---|---|"
run "deps compile (cold)" "rm -rf _build/$MIX_ENV" "mix deps.compile"
run "app compile (cold)" "rm -rf _build/$MIX_ENV/lib/$app" "mix compile"
run "no-op compile" "true" "mix compile"
run "edit router" "printf '\\n# bench %s\\n' \$(date +%s%N) >> $web/router.ex" "mix compile" count
run "edit core_components" "printf '\\n# bench %s\\n' \$(date +%s%N) >> $web/components/core_components.ex" "mix compile" count
run "edit schema" "printf '\\n# bench %s\\n' \$(date +%s%N) >> lib/$app/catalog/catalog_alpha.ex" "mix compile" count
run "edit context" "printf '\\n# bench %s\\n' \$(date +%s%N) >> lib/$app/catalog.ex" "mix compile" count
run "edit liveview" "printf '\\n# bench %s\\n' \$(date +%s%N) >> $web/live/catalog_alpha_live/index.ex" "mix compile" count
run "test env compile (cold)" "rm -rf _build/test/lib/$app" "env MIX_ENV=test mix compile"

# undo the benchmark edits
git checkout -q -- lib 2>/dev/null || true
