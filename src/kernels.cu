extern "C" __global__ void burn(unsigned long long cycles,unsigned long long seed){unsigned long long start=clock64(),x=(unsigned long long)threadIdx.x+(unsigned long long)blockIdx.x*1315423911ULL+seed;while(clock64()-start<cycles)x=x*2862933555777941757ULL+3037000493ULL;if(x==7ULL)asm volatile("");}
extern "C" __global__ void fmaProbe(float*out,int n,int iterations){int i=blockIdx.x*blockDim.x+threadIdx.x;if(i<n){float x=1.0001f+(i&31)*1e-5f;
#pragma unroll 1
for(int j=0;j<iterations;j++)x=fmaf(x,1.00001f,0.99999f);out[i]=x;}}
extern "C" __global__ void triad(const float*a,const float*b,float*c,int n){int i=blockIdx.x*blockDim.x+threadIdx.x;if(i<n)c[i]=a[i]*1.25f+b[i];}
