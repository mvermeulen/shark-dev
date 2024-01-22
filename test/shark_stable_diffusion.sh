#!/bin/bash
#
# Expects to run in the SHARK root directory
DEVICE=${DEVICE:=""}

if [ ! -f apps/stable_diffusion/scripts/main.py ]; then
    "stable diffusion not found, are you in a SHARK root directory?"
    exit 0
fi

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "VIRTUAL_ENV is empty have you done source shark1.venv/bin/activate?"
    exit 1
fi

if [ "$DEVICE" = "" ]; then
    if [ -d /opt/rocm ]; then
	DEVICE=rocm
    elif [ -d /usr/local/cuda ]; then
	DEVICE=cuda
    else
	DEVICE=cpu
    fi
fi

python apps/stable_diffusion/scripts/main.py --app=txt2img --precision=fp16 --device=$DEVICE --prompt="a photograph of an astronaut riding a horse" --seed 13
