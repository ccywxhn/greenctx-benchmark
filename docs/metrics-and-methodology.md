# Metrics and methodology

CSV columns: suite, mode, iterations, latency_p50_ms, latency_p95_ms, latency_p99_ms, kernel_gpu_time_ms, throughput_value, throughput_unit, background_time_ms, critical_sm_count, background_sm_count, critical_sm_ratio, background_sm_ratio.

- Latency is host submit-to-completion measured with steady_clock; warm-up samples are excluded.
- P50/P95/P99 are calculated over measured samples. Use at least 20 iterations for exploratory tail latency and more for stable estimates.
- Kernel GPU time uses CUDA Driver API events.
- Critical throughput is completed critical kernels per second, based on median host latency.
- Background time is host-observed time until the background completion event.
- SM counts are queried through cuGreenCtxGetDevResource; ratios are relative to physical device SM count.
- NA means not applicable or not measured, never zero.

Three warm-up iterations are used. clock64() generates synthetic work. Triad counts two reads plus one write (12 nominal bytes/element), not a strict DRAM microbenchmark. Primary Context is full-device and not an equal-SM-budget comparison. Green Contexts do not guarantee concurrent execution or forward progress; verify overlap with Nsight Systems.

For multi-Green-Context runs, background_sm_count is the sum of other provisioned Green Context partitions, not active SM occupancy.
