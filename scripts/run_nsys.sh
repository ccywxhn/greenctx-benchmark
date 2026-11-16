#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$BASH_SOURCE")/.." && pwd)"
command -v nsys >/dev/null || { echo "nsys not found"; exit 1; }
nsys profile --trace=cuda --force-overwrite=true -o "\${1:-$ROOT/greenctx-driver-api}" "$ROOT/build/greenctx_bench" --suite all --device "\${DEVICE:-0}" --iterations "\${ITERATIONS:-20}"
