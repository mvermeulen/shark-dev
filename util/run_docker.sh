#!/bin/bash
#
# Script pass the right parameters to run docker on ROCm
# includes mounting /home/mev
DOCKER=${DOCKER:="ort-migraphx:6.0"}
PRIVILEGED=${PRIVILEGED:=""} # pass in --privileged if needed
CACHE=""

rocm_opts="--device=/dev/dri --device=/dev/kfd --network=host --group-add=render"
cuda_opts="--gpus all"

# Use the installed directories as a clue, not perfect but close to what is needed
if [ -d /opt/rocm ]; then
    device_opts=$rocm_opts
elif [ -d /usr/local/cuda ]; then
    device_opts=$cuda_opts
else
    device_opts=""
fi


if [ `id -u` != 0 ]; then
    echo script should be run as root
    exit 0
fi

if [ -d /home/mev/source/shark-dev/cache/shark_tank ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/cache/shark_tank:/root/.local/shark_tank"
fi

if [ -d /home/mev/source/shark-dev/cache/huggingface ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/cache/huggingface:/root/.cache/huggingface"
fi

if [ -d /home/mev/source/shark-dev/cache/torch ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/cache/torch:/root/.cache/torch"
fi

if [ -d /home/mev/source/shark-dev/cache/pip ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/cache/pip:/root/.cache/pip"
fi

if [ -d /home/mev/source/shark-dev/cache/onnx ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/cache/onnx:/root/.cache/onnx"
fi

if [ -d /home/mev/source/shark-dev/results ]; then
    CACHE="$CACHE -v /home/mev/source/shark-dev/results:/workdir/test_results"
fi

docker run -it -e TZ=America/Chicago $CACHE $PRIVILEDGED $device_opts -v /home/mev:/home/mev $DOCKER /bin/bash
