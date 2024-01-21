#!/bin/bash
#
# Builds ONNX runtime.
# On a ROCm platform, includes MIGraphX.
# On a CUDA platform builds with CUDA provider.
ORT_REPOSITORY=${ORT_REPOSITORY:="https://github.com/mvermeulen/onnxruntime"}
ORT_BRANCH=${ORT_BRANCH:="mev_add_shark"}
WORKDIR=${WORKDIR:="/workdir"}

if [ $(dpkg -l rocm-core | grep -c rocm-core) != 0 ]; then
    ROCM_VERSION=`dpkg -l rocm-core | awk '{ print $3 }' | awk -F. '{ print $1 "." $2 }'`
    CUDA_VERSION=""
    device_opts="--use-migraphx --use_rocm --rocm_version=${ROCM_VERSION} --rocm_home=/opt/rocm"
elif [ -d /usr/local/cuda-12.2 ]; then
    ROCM_VERSION=""
    CUDA_VERSION="12.2"
    device_opts="--use_cuda --cuda_version=${CUDA_VERSION} --cuda_home=/usr/local/cuda-12.2"
fi

pip3 install packaging

# update cmake
CMAKE_VERSION=3.26.6
cd /usr/local && \
    wget -q -O - https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz | tar zxf -
export PATH=/usr/local/cmake-${CMAKE_VERSION}-linux-x86_64/bin:$PATH

# build ONNX runtime
cd /src
git clone --recursive --branch ${ORT_BRANCH} --depth=1 ${ORT_REPOSITORY}
cd onnxruntime
./build.sh --parallel --cmake_extra_defines ONNXRUNTIME_VERSION=`cat ./VERSION_NUMBER` CMAKE_HIP_FLAGS=-Wno-deprecated-builtins --config Release --skip_tests --build_wheel $device_opts --allow_running_as_root

cp /src/onnxruntime/build/Linux/Release/dist/*.whl ${WORKDIR}
pip3 install /src/onnxruntime/build/Linux/Release/dist/*.whl

# set up python environment
cd /src/onnxruntime/onnxruntime/python/tools/transformers
pip3 install -r requirements.txt
pip3 uninstall -y torch
pip3 install torch --index-url https://download.pytorch.org/whl/nightly/rocm5.7
if [ "$ROCM_VERSION" = "6.0" ]; then
    pip3 install tensorflow-rocm==2.13.1.600
elif [ "$ROCM_VERSION" = "5.7" ]; then
    pip3 install tensorflow-rocm==2.13.0.570
elif [ "$ROCM_VERSION" != "" ]; then
    echo "unknown rocm version, tensorflow-rocm is not installed"
elif [ "$CUDA_VERSION" != "" ]; then
    pip3 install tensorflow-gpu
else
    echo "no CUDA_VERSION and no ROCM_VERSION is found"
fi
