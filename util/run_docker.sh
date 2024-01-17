#!/bin/bash
#
# Script pass the right parameters to run docker on ROCm
# includes mounting /home/mev
DOCKER=${DOCKER:="ort-migraphx:6.0"}
CACHE=""

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
    CACHE="$CACHE -v /home/mev/source/cache/torch:/root/.cache/torch"
fi

docker run -it -e TZ=America/Chicago $CACHE --device=/dev/dri --device=/dev/kfd --network=host --group-add=video -v /home/mev:/home/mev $DOCKER /bin/bash
