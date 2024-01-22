#!/bin/bash
#
# Uses tags to save docker images on a particular day

if [ `id -u` != 0 ]; then
    echo "script should be run as root"
    exit 0
fi

datestamp=`date '+%Y-%m-%d'`

if [ -d /opt/rocm ]; then
    for dockerid in rocm:5.7 rocm:6.0 shark:5.7 shark:6.0 migraphx:5.7 migraphx:6.0 ort-migraphx:5.7 ort-migraphx:6.0
    do
	docker tag $dockerid $dockerid-${datestamp}
    done
elif [ -d /usr/local/cuda ]; then
    for dockerid in cuda:11 cuda:12 shark:11 shark:12 ort-cuda:11 ort-cuda:12 tensorrt:12 ort-tensorrt:12
    do
	docker tag $dockerid $dockerid-${datestamp}
    done
fi

