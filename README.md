# Green Context Benchmark V3 — CUDA Driver API

A CUDA Driver API benchmark for NVIDIA Green Context SM partitioning and Work Queue sharing scopes.

## API policy
The host benchmark uses the CUDA Driver API for device discovery, resource partitioning, Green Context creation, context conversion, stream creation, module loading, kernel launch, events, and device memory. It does not call CUDA Runtime API functions or use Runtime kernel-launch syntax.

The project targets CUDA Toolkit 13.1+ because it exercises Work Queue configuration scopes.

## Requirements
- Linux x86-64
- NVIDIA GPU and compatible NVIDIA driver
- CUDA Toolkit 13.1+
- CMake 3.24+ and C++17 compiler

## Build
    bash scripts/build.sh

## Run
    ./build/greenctx_bench --suite all
    ./build/greenctx_bench --suite primary-vs-green
    ./build/greenctx_bench --suite sm-partition-sweep
    ./build/greenctx_bench --suite compute-memory-throughput
    ./build/greenctx_bench --suite multi-green-context
    ./build/greenctx_bench --suite workqueue-scope

Common options: --device N, --iterations N, --csv FILE.

## Suites
| Selector | Function | Purpose |
|---|---|---|
| primary-vs-green | runPrimaryVsGreenContextComparison | Full-device Primary Context baseline versus two disjoint SM Green Contexts |
| sm-partition-sweep | runSmPartitionSweep | Sweep critical Green Context SM share from 20% through 80% |
| compute-memory-throughput | runComputeAndMemoryThroughput | Driver-launched FMA and memory-triad probes |
| multi-green-context | runMultiGreenContextConcurrency | Critical latency while 2/4/8 Green Contexts receive background work |
| workqueue-scope | runWorkqueueScopeComparison | DeviceCtx versus GreenCtxBalanced with two disjoint SM partitions |

Latency suites perform three warm-up launches, then collect --iterations samples. P50/P95/P99 exclude warm-ups. CSV records both critical/background SM counts and ratios. Primary Context is unpartitioned and not an equal-SM-budget comparison. GreenCtxBalanced is best-effort, not a guarantee of concurrency or forward progress. Verify overlap with Nsight Systems. clock64() is synthetic work, not a precision timer. Memory triad is a bandwidth probe, not a strict DRAM microbenchmark.
