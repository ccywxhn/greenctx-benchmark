# Green Context Benchmark V3

CUDA 13.1+ benchmark suite for NVIDIA Green Context SM partitioning and workqueue scope.

## Requirements
- Linux x86-64
- NVIDIA GPU and compatible driver
- CUDA Toolkit 13.1+
- CMake 3.24+ and C++17 compiler

## Build
    bash scripts/build.sh

## Run all benchmark suites
    ./build/greenctx_bench --suite all

## Run one suite by its function
    ./build/greenctx_bench --suite primary-vs-green
    ./build/greenctx_bench --suite sm-partition-sweep
    ./build/greenctx_bench --suite compute-memory-throughput
    ./build/greenctx_bench --suite multi-green-context
    ./build/greenctx_bench --suite workqueue-scope

Common options: --device N, --iterations N, --csv FILE.

## Benchmark suite overview

| Suite selector | Function | What it measures |
|---|---|---|
| primary-vs-green | runPrimaryVsGreenContextComparison | Primary Context two-stream baseline versus two SM-partitioned Green Contexts |
| sm-partition-sweep | runSmPartitionSweep | Sweep critical/background SM allocation from 20% to 80% |
| compute-memory-throughput | runComputeAndMemoryThroughput | FMA compute throughput and memory-triad bandwidth probes |
| multi-green-context | runMultiGreenContextConcurrency | 2/4/8 independent Green Contexts, background submission and critical-task latency |
| workqueue-scope | runWorkqueueScopeComparison | DeviceCtx versus GreenCtxBalanced Work Queue sharing scope |

## Interpretation
- Primary baseline is Full GPU / Unpartitioned; it is not an equal-SM-budget comparison.
- Requested SM ratios can be quantized or rejected by architecture alignment constraints.
- GreenCtxBalanced is a best-effort workqueue-sharing policy, not guaranteed disjoint queues.
- Green Contexts do not guarantee concurrent execution or forward progress.
- Verify actual overlap with Nsight Systems using bash scripts/run_nsys.sh.
- clock64() busy-wait is a workload generator, not a precision timer.
- Memory triad is a bandwidth probe, not a strict DRAM microbenchmark.

See docs/architecture.md, docs/metrics-and-methodology.md, docs/api-compatibility.md and tests/README.md.
