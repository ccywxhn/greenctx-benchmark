# Architecture

This project uses the CUDA Runtime execution-context Green Context API (CUDA 13.1+).

1. Query SM resources with cudaDeviceGetDevResource.
2. Partition SM resources with cudaDevSmResourceSplit or cudaDevSmResourceSplitByCount.
3. Generate descriptors with cudaDevResourceGenerateDesc.
4. Provision contexts with cudaGreenCtxCreate.
5. Create streams with cudaExecutionCtxStreamCreate and submit kernels to those streams.

The benchmark queries actual SM counts from created execution contexts. Requested ratios can be rounded by hardware partition and co-scheduling alignment requirements.

Workqueue configuration is attached as a cudaDevResourceTypeWorkqueueConfig resource. GreenCtxBalanced asks the driver to try to avoid overlapping workqueues across Green Contexts, guided by wqConcurrencyLimit. It is best-effort, not a hard isolation or concurrency guarantee.
