# Test matrix
1. Primary-context two-stream baseline versus two Green Contexts.
2. Critical/background SM split sweep from 20% to 80%; hardware alignment may quantize requested sizes.
3. FMA compute probe and memory triad bandwidth probe.
4. 2/4/8 Green Contexts; background kernels are submitted on independent contexts before the critical context.
5. Workqueue configuration comparison: DeviceCtx versus GreenCtxBalanced.
Unavailable legal partitions are reported as SKIP.
