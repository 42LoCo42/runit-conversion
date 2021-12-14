#!/usr/bin/env sh
XDG_RUNTIME_DIR="/tmp/xdg-runtime-dir-$(id -u)"
export XDG_RUNTIME_DIR
# shellcheck disable=SC2174 # we want -m to only affect the deepest level
mkdir -m 700 -p "$XDG_RUNTIME_DIR"
