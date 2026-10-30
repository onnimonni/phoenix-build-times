#!/usr/bin/env bash
# Runs a command inside the devenv shell: ./run.sh 'mix test'
exec devenv shell -- bash -c "$*"
