#!/usr/bin/env sh
XDG_RUNTIME_DIR="/tmp/xdg-runtime-dir-$(id -u)"
export XDG_RUNTIME_DIR
mkdir -p "$XDG_RUNTIME_DIR"
