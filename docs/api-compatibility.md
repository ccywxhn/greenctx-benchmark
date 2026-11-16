# API compatibility and implementation notes

## CUDA Driver API only
Host code includes cuda.h and links CUDA::cuda_driver. Device kernels are compiled to PTX by NVCC as a build-time step, then loaded and launched through Driver API module functions. No CUDA Runtime API functions are called by the host benchmark. Kernel launch uses cuLaunchKernel; streams/events/memory use cuStream*, cuEvent*, and cuMem*.

## Green Context flow
1. cuInit and cuDeviceGet select the device.
2. cuDeviceGetDevResource obtains device SM resources.
3. cuDevSmResourceSplit or cuDevSmResourceSplitByCount partitions them.
4. cuDevResourceGenerateDesc creates the resource descriptor.
5. cuGreenCtxCreate provisions the Green Context.
6. cuCtxFromGreenCtx obtains the CUcontext view used by context-taking Driver APIs.
7. cuGreenCtxStreamCreate creates a stream associated with the Green Context.
8. cuModuleLoad and cuLaunchKernel load and launch PTX kernels.

The CUcontext returned by cuCtxFromGreenCtx is treated as a borrowed view; the Green Context owns its lifetime. Streams and modules are destroyed before the Green Context.

## Work Queue scope comparison
Both contexts receive distinct SM partitions from the same split operation. Each receives a Work Queue configuration resource with CU_WORKQUEUE_SCOPE_DEVICE_CTX or CU_WORKQUEUE_SCOPE_GREEN_CTX_BALANCED. Balanced asks the driver to use non-overlapping Work Queue resources where possible; it is not an unconditional isolation guarantee.

CUDA Toolkit 13.1+ is the project baseline for Driver API Work Queue configuration. Verify installed cuda.h and target driver when porting.
