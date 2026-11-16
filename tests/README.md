# Benchmark suites (CUDA Driver API)

All host-side CUDA operations use the Driver API.

| CLI selector | C++ function | Purpose |
|---|---|---|
| primary-vs-green | runPrimaryVsGreenContextComparison() | Unpartitioned Primary Context baseline versus two Green Contexts with disjoint SM partitions. |
| sm-partition-sweep | runSmPartitionSweep() | Critical/background SM allocation sweep from 20% to 80%. |
| compute-memory-throughput | runComputeAndMemoryThroughput() | Driver-launched FMA compute and memory-triad probes. |
| multi-green-context | runMultiGreenContextConcurrency() | 2, 4, and 8 Green Contexts with repeated critical latency samples under background work. |
| workqueue-scope | runWorkqueueScopeComparison() | DeviceCtx versus GreenCtxBalanced Work Queue scopes, with two distinct SM partitions. |

Run all suites:
    ./build/greenctx_bench --suite all --iterations 20

Unsupported partitions or Work Queue configurations should be reported as SKIP/errors, not interpreted as zero. Multi-context background SM count is the sum of other provisioned partitions, not proof of simultaneous activity.
