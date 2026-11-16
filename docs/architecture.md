# Architecture — CUDA Driver API

This benchmark uses the CUDA Driver API for all host-side CUDA operations. Device kernels are compiled to PTX at build time, loaded with cuModuleLoad, and launched with cuLaunchKernel.

1. Initialize the Driver API with cuInit and select a CUdevice.
2. Query SM resources with cuDeviceGetDevResource.
3. Partition SM resources with cuDevSmResourceSplit or cuDevSmResourceSplitByCount.
4. Generate resource descriptors with cuDevResourceGenerateDesc.
5. Provision Green Contexts with cuGreenCtxCreate.
6. Convert each CUgreenCtx to a CUcontext view with cuCtxFromGreenCtx.
7. Create streams with cuGreenCtxStreamCreate.
8. Load the PTX module into the relevant context and submit kernels through cuLaunchKernel.

The benchmark queries actual SM counts from each Green Context with cuGreenCtxGetDevResource. Requested ratios can be quantized by hardware partition and co-scheduling alignment requirements.

Work Queue configuration is attached as a CU_DEV_RESOURCE_TYPE_WORKQUEUE_CONFIG resource. CU_WORKQUEUE_SCOPE_GREEN_CTX_BALANCED asks the driver to avoid overlapping Work Queue resources across balanced Green Contexts where possible; it is not a hard isolation or concurrency guarantee.

The Primary Context baseline remains unpartitioned. It is a full-device reference, not an equal-SM-budget control group.
