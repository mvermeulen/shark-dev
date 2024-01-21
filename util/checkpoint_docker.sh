#!/bin/bash
#
# Uses tags to save docker images on a particular day

if [ `id -u` != 0 ]; then
    echo "script should be run as root"
    exit 0
fi

datestamp=`date '+%Y-%m-%d'`

for dockerid in rocm:5.7 rocm:6.0 shark:5.7 shark:6.0 migraphx:5.7 migraphx:6.0 ort-migraphx:5.7 ort-migraphx:6.0
do
    docker tag $dockerid $dockerid-${datestamp}
done
