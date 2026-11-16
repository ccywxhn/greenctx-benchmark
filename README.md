# Green Context Benchmark V3

CUDA 13.1+ benchmark suite for NVIDIA Green Context SM partitioning and workqueue scope.

## Requirements
- Linux x86-64
- NVIDIA GPU and compatible driver
- CUDA Toolkit 13.1+
- CMake 3.24+ and C++17 compiler

## Build and run
    ./scripts/build.sh
    ./build/greenctx_bench --help
    ./scripts/run_all.sh

Run one suite with --test 1 through --test 5. Select device and sample count using --device N and --iterations N. CSV output can be changed with --csv FILE.

## Suites
1. Primary-context two-stream baseline vs two Green Contexts.
2. Critical/background SM partition sweep, 20–80%.
3. FMA compute and memory triad probes.
4. 2/4/8 independent Green Contexts.
5. Workqueue DeviceCtx vs GreenCtxBalanced.

## Interpretation
- Primary baseline is Full GPU / Unpartitioned; it is not an equal-SM-budget comparison.
- Requested SM ratios can be quantized or rejected by architecture alignment constraints.
- GreenCtxBalanced is a best-effort workqueue-sharing policy, not guaranteed disjoint queues.
- Green Contexts do not guarantee concurrent execution or forward progress.
- Verify actual overlap with Nsight Systems using scripts/run_nsys.sh.
- clock64() busy-wait is a workload generator, not a precision timer.
- Memory triad is a bandwidth probe, not a strict DRAM microbenchmark.

See docs/architecture.md, docs/metrics-and-methodology.md, docs/api-compatibility.md and tests/README.md.
