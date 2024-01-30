#!/bin/bash
set -x
mkdir -p /src/tvm/build
cd /src/tvm/build

CONFIG_CMAKE=../cmake/config.cmake

if [ -d /opt/rocm ]; then
    sed -e 's?USE_ROCM OFF?USE_ROCM ON?g' \
	-e 's?USE_LLVM OFF?USE_LLVM /opt/rocm/llvm/bin/llvm-config?g' \
	-e 's?USE_MIOPEN OFF?USE_MIOPEN ON?g' \
	-e 's?USE_ROCBLAS OFF?USE_ROCBLAS ON?g' \
	../cmake/config.cmake > config.cmake.rocm
    CONFIG_CMAKE=config.cmake.rocm
elif [ -d /usr/local/cuda ]; then
    sed -e 's?USE_CUDA OFF?USE_CUDA ON?g' \
	-e 's?USE_CUDNN OFF?USE_CUDNN ON?g' \
	-e 's?USE_CUBLAS OFF?USE_CUBLAS ON?g' \
	../cmake/config.cmake > config.cmake.cuda
    CONFIG_CMAKE=config.cmake.cuda
fi

sed -e 's?USE_RELAY_DEBUG OFF?USE_RELAY_DEBUG ON?g' $CONFIG_CMAKE > config.cmake

cmake -DCMAKE_CXX_FLAGS="-D__HIP_PLATFORM_AMD__"  ..
make -j 4

cd /src/tvm/python
pip3 install -U numpy
python3 setup.py install
