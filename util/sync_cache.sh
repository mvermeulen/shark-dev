#!/bin/bash
#
# script to update cached artifacts to the root docker build directory so they can be copied
# the next time we generate a docker
BUILD_REPO=${BUILD_REPO:="/home/mev/source/shark-dev"}

# update shark_tank
cd /root/.local/shark_tank
ls | while read dir
do
    if [ ! -d ${BUILD_REPO}/docker/shark_tank/${dir} ]; then
	echo saving shark_tank/${dir}
	cp -r ${dir} ${BUILD_REPO}/docker/shark_tank
    fi
done

# update huggingface
cd /root/.cache/huggingface/hub
ls | while read dir
do
    if [ -d ${dir} && ! -d ${BUILD_REPO}/docker/huggingface/hub/${dir} ]; then
	echo saving huggingface/hub/${dir}
	cp -r ${dir} ${BUILD_REPO}/docker/huggingface/hub
    fi
done

# update torch
cd /root/.cache/torch/hub/checkpoints
ls *.pth | while read model
do
    if [ ! -f ${BUILD_REPO}/docker/torch/hub/checkpoints/${model} ]; then
	echo saving torch/hub/checkpoints/${model}
	cp ${model} ${BUILD_REPO}/docker/torch/hub/checkpoints
    fi
done

