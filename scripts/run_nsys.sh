#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
command -v nsys >/dev/null || { echo "nsys not found"; exit 1; }
nsys profile --trace=cuda,nvtx --force-overwrite=true -o "${1:-$ROOT/greenctx-v3}" "$ROOT/build/greenctx_bench" --test all --device "${DEVICE:-0}" --iterations "${ITERATIONS:-10}"
