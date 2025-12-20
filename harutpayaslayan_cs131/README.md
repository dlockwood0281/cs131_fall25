CS131 Fall 2025 Semester Project 
CUDA: Compute Unified Device Architecture 
Project Summary (Humanized & Paraphrased): 

In my project presentation, I provide an in-depth exploration of NVIDIA’s CUDA platform, a powerful technology that unlocks the immense parallel computing capabilities of modern GPUs, which can contain thousands of individual cores. I describe what CUDA is, why it was developed, and how this enables GPUs to outperform CPUs on data-intensive workloads.

From the basics of the CUDA programming model and thread/memory organization to how real applications use CUDA for everything from AI and medicine to finance and simulations, and even how optimization techniques are used to get the best performance, my project delves into the core concepts that make GPU acceleration such an effective solution. Ultimately, the goal of my project is to demystify CUDA and explain why it has become an essential tool in the world of high-performance computing and what makes it likely to continue to be an important technology into the future.

Project Contents (Humanized & Paraphrased): 
What is CUDA? 

What CUDA is, the reason NVIDIA developed it, and how it allowed programmers to use GPU for general purpose computing, not just graphics.

The GPU Architecture Advantage 

Why GPUs are so much faster — the reasons including the thousands of smaller cores, the extremely high memory bandwidth, and the SIMT execution model that allows so much work to be done in parallel.

CUDA Programming Model 

How CUDA programs actually work — writing kernels and managing memory, how data is transferred back and forth between CPU and GPU, how threads are launched, and how results are retrieved.

Thread Hierarchy 

Threads, blocks, grids, warps, and the layered hierarchy that they form, as well as how this relates to the scheduling and execution done by the GPU hardware itself.

Memory Hierarchy 

The types of memory available in CUDA (global, shared, registers, constant, and texture memory), and how the right choice for each type of data is crucial for high performance.

Real-World Applications 

Practical examples of where and how CUDA is being used today, such as in deep learning, medical imaging, scientific research, financial modeling, and other compute-intensive fields.

Performance Comparison 

How GPUs can outperform CPUs so dramatically in parallel workloads such as matrix operations and training deep neural networks, including the typical range of speedup.

Optimization Strategies 

A simplified introduction to key optimization concepts such as memory coalescing, occupancy, warp divergence, and the use of NVIDIA Nsight to profile and debug CUDA applications.

CUDA Setup & First Steps 

The main tools needed to get started with CUDA programming, including the CUDA Toolkit, Nsight, CUDA libraries, documentation, and some useful online learning resources.

Lessons Learned 

The key ideas that one should take away from this presentation: the massive parallelism available on GPUs, how accessible and approachable CUDA is for developers, and the performance gains that can be achieved by understanding the underlying architecture.
