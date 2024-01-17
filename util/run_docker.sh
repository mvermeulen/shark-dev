#!/bin/bash
#
# Script pass the right parameters to run docker on ROCm
# includes mounting /home/mev
DOCKER=${DOCKER:="ort-migraphx:6.0"}

if [ `id -u` != 0 ]; then
    echo script should be run as root
    exit 0
fi

if [ -d /extra ]; then
    EXTRAMOUNT="-v /extra:/extra"
else
    EXTRAMOUNT=""
fi

docker run -it -e TZ=America/Chicago -e TARGET=gpu --device=/dev/dri --device=/dev/kfd --network=host --group-add=video -v /home/mev:/home/mev $EXTRAMOUNT $DOCKER /bin/bash
