#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT/build/greenctx_bench" --test all --device "${DEVICE:-0}" --iterations "${ITERATIONS:-20}" --csv "${CSV:-$ROOT/results.csv}"
