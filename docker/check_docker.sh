#!/bin/bash
#
# check_docker.sh - looks to see if the docker exists if so, touches the tag file
#    $1 - name of docker (for grep)
#    $2 - name of tag (for touch)
#
if [ "$(id -u)" -ne 0 ]; then
    echo check docker expects to run as root
    exit 1
fi

if [ "$1" = "" -o "$2" = "" ]; then
    echo check_docker.sh missing arguments
    exit -1
fi

if $(docker images | awk '{ print $1 ":" $2 }' | grep -q $1); then
    touch $2
    exit 0
else    
    echo docker $1 not found
    exit 1
fi

    
   
