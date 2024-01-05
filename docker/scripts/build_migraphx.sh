#!/bin/bash
#
# Build MIGraphX from source
INSTALLDIR=${INSTALLDIR:="/src"}
WORKDIR=${WORKDIR:="/workdir"}
GPU_TARGETS=${GPU_TARGETS:="gfx906;gfx1030"}

CMAKE_VERSION=3.26.6
cd /usr/local && \
    wget -q -O - https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz | tar zxf -
export PATH=/usr/local/cmake-${CMAKE_VERSION}-linux-x86_64/bin:$PATH

pip3 install https://github.com/RadeonOpenCompute/rbuild/archive/master.tar.gz
mkdir -p ${INSTALLDIR}
cd ${INSTALLDIR}
git clone --depth=1 https://github.com/ROCm/AMDMIGraphX
cd AMDMIGraphX
rbuild package --cxx /opt/rocm/llvm/bin/clang++ -d ${INSTALLDIR}/AMDMIGraphX/depend -B ${INSTALLDIR}/AMDMIGraphX/build -DGPU_TARGETS=${GPU_TARGETS}
cd build
dpkg -i *.deb

