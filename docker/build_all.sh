#!/bin/bash
TAG=${TAG:="6.0"}
CACHE=${CACHE:=""}
DATESTAMP=`date '+%Y%m%d-%H%M'`

docker build -f rocm-dev -t rocm:${TAG} ${CACHE}\
       --build-arg install_script="https://repo.radeon.com/amdgpu-install/6.0/ubuntu/jammy/amdgpu-install_6.0.60000-1_all.deb" \
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
