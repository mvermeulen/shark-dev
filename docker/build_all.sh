#!/bin/bash
ROCM_VERSION=${ROCM_VERSION:="5.7"}

# Set to "--no-cache" to rebuild the world
CACHE=${CACHE:=""}

# NOTE: SHARK-1.0 requires ROCm 5.7.
#       MIGraphX can use ROCm 6.0
case $ROCM_VERSION in
    5.7)
	TAG=${TAG:="5.7"}
	INSTALL_SCRIPT="https://repo.radeon.com/amdgpu-install/5.7.1/ubuntu/jammy/amdgpu-install_5.7.50701-1_all.deb"
	 ;;
    6.0)
	TAG=${TAG:="6.0"}
	INSTALL_SCRIPT="https://repo.radeon.com/amdgpu-install/6.0/ubuntu/jammy/amdgpu-install_6.0.60000-1_all.deb"
	 ;;
esac


DATESTAMP=`date '+%Y%m%d-%H%M'`

docker build -f rocm-dev -t rocm:${TAG} ${CACHE}\
       --build-arg install_script=${INSTALL_SCRIPT} \
       . 2>&1 | tee rocm:${TAG}.${DATESTAMP}.log
docker tag rocm:${TAG} rocm:${DATESTAMP}

docker build -f shark-dev -t shark:${TAG} ${CACHE}\
       --build-arg base_docker=rocm:${TAG} \
       . 2>&1 | tee shark.${TAG}.${DATESTAMP}.log
docker tag shark:${TAG} shark:${DATESTAMP}

docker build -f migraphx-dev -t migraphx:${TAG} ${CACHE}\
       --build-arg base_docker=rocm:${TAG} \
       . 2>&1 | tee migraphx:${TAG}.${DATESTAMP}.log
docker tag migraphx:${TAG} migraphx:${DATESTAMP}

docker build -f ort-migraphx-dev -t ort-migraphx:${TAG} ${CACHE}\
       --build-arg base_docker=migraphx:${TAG} \
       . 2>&1 | tee ort-migraphx:${TAG}.${DATESTAMP}.log
docker tag ort-migraphx:${TAG} ort-migraphx:${DATESTAMP}
