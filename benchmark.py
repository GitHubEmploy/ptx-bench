from numba import cuda
import numpy as np
import time

@cuda.jit
def gpu_kernel(num_iters, res):
    if cuda.threadIdx.x == 0 and cuda.blockIdx.x == 0:
        total = 0
        for i in range(num_iters):
            total += i
        res[0] = total

def main():
    num_iters = 100000000
    res = np.zeros(1, dtype=np.uint64)
    d_res = cuda.to_device(res)
    
    t_start = time.perf_counter()
    gpu_kernel[1, 1](num_iters, d_res)
    cuda.synchronize()
    t_end = time.perf_counter()
    
    d_res.copy_to_host(res)
    
    print("Python GPU Benchmark (Numba):")
    print("Iterations:", num_iters)
    print("Result (sum):", res[0])
    print("Kernel execution time: {:.6f} seconds".format(t_end - t_start))

if __name__ == '__main__':
    main()
