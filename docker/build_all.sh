#!/bin/bash
#
# Updated to use the Makefile
# Hard coded to assume ROCm 5.7, ROCm 6.0 and CUDA 12 for now.

if [ ! -d tags ]; then
    echo "tags not found, expect to run in the shark-dev/docker directory"
    exit 1
fi

if [ -d /opt/rocm ]; then
    if [ -f tags/rocm5.7 ]; then
	rm tags/rocm5.7
    fi    
    if [ -f tags/rocm6.0 ]; then
	rm tags/rocm6.0
    fi
    make rocm
elif [ -d /usr/local/cuda ]; then
    if [ -f tags/cuda-12 ]; then
	rm tags/cuda-12
    fi
    make cuda
fi

