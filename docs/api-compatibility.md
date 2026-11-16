# API compatibility

- Linux x86-64, NVIDIA GPU/driver supporting Green Contexts, CUDA Toolkit 13.1+.
- Uses CUDA Runtime APIs: cudaDeviceGetDevResource, cudaDevSmResourceSplit, cudaDevSmResourceSplitByCount, cudaDevResourceGenerateDesc, cudaGreenCtxCreate, cudaExecutionCtxStreamCreate, cudaExecutionCtxGetDevResource, cudaExecutionCtxDestroy.
- Workqueue fields: device, sharingScope, wqConcurrencyLimit.
- Workqueue scopes: cudaDevWorkqueueConfigScopeDeviceCtx and cudaDevWorkqueueConfigScopeGreenCtxBalanced.
- Legal SM partition sizes depend on GPU architecture and alignment; actual SM counts are queried.
- This repository has not been compiled or run on the target user's GPU in this environment. Build and runtime validation are still required on the target system.
