# Benchmark suites

Use semantic suite selectors instead of ordinal test numbers.

| CLI selector | C++ function | Purpose |
|---|---|---|
| `primary-vs-green` | `runPrimaryVsGreenContextComparison()` | Compare a Primary Context with two streams against two Green Contexts with separate SM resource partitions. |
| `sm-partition-sweep` | `runSmPartitionSweep()` | Sweep the critical-context SM share from 20% through 80%, assigning the remainder to background work. |
| `compute-memory-throughput` | `runComputeAndMemoryThroughput()` | Probe FMA compute throughput and memory-triad bandwidth. |
| `multi-green-context` | `runMultiGreenContextConcurrency()` | Create 2, 4, and 8 Green Contexts; submit background kernels to independent contexts before critical work. |
| `workqueue-scope` | `runWorkqueueScopeComparison()` | Compare DeviceCtx and GreenCtxBalanced Work Queue configuration scopes. |

Run all suites with:

```bash
./build/greenctx_bench --suite all
```

Run a specific suite, for example:

```bash
./build/greenctx_bench --suite sm-partition-sweep
```

Unsupported legal partition sizes or Work Queue configurations should be reported as SKIP, not interpreted as zero-valued measurements.
