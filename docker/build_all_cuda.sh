#!/bin/bash
#set -x
CUDA_VERSION=${CUDA_VERSION:="12.2"}

# Set to "--no-cache" to rebuild the world
CACHE=${CACHE:=""}

case $CUDA_VERSION in
    12.2)
	TAG=${TAG:="cuda-12.2"}
	CUDA_BASE="nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04"
	;;
esac

DATESTAMP=`date '+%Y%m%d-%H%M'`
docker build -f cuda-dev -t cuda:${TAG} ${CACHE} \
       --build-arg base_docker=${CUDA_BASE} \
       . 2>&1 | tee cuda:${TAG}.${DATESTAMP}.log
docker tag cuda:${TAG} cuda:${DATESTAMP}

docker build -f shark-dev -t shark:${TAG} ${CACHE} \
       --build-arg base_docker=cuda:${TAG} \
       . 2>&1 | tee shark.${TAG}.${DATESTAMP}.log
docker tag shark:${TAG} shark:${DATESTAMP}
