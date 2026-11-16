# Metrics and methodology

CSV columns: latency_p50_ms, latency_p95_ms, latency_p99_ms, kernel_gpu_time_ms, total_throughput, throughput_unit, background_time_ms, sm_allocation.

- Latency is host submit-to-complete measured with steady_clock.
- Kernel GPU time is measured with CUDA events.
- Critical throughput is completed critical kernels per second; Test 3 reports GFLOP/s and nominal GB/s.
- Background time is host-observed time until background events complete.
- SM allocation is queried from the created Green Context; primary baseline is Full GPU / Unpartitioned.

The busy-wait kernel uses clock64() as a workload generator, not a precision timer. Test 3 triad counts two reads and one write (12 nominal bytes/element) and uses a 64 Mi-element working set; it is a bandwidth probe, not a strict DRAM microbenchmark.

Test 4 submits background work to distinct Green Context streams before the critical work. Resource partitioning alone does not prove simultaneous execution; verify overlap using Nsight Systems.

Primary baseline has full-GPU access and is not an equal-SM-budget comparison against partitioned Green Contexts. Green Contexts do not guarantee concurrency or forward progress.
