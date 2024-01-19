#!/bin/bash
#
# Expects to run in the SHARK root directory
if [ ! -f apps/stable_diffusion/scripts/main.py ]; then
    "stable diffusion not found, are you in a SHARK root directory?"
    exit 0
fi

if [ -d /opt/rocm ]; then
    DEVICE=rocm
elif [ -d /usr/local/cuda ]; then
    DEVICE=cuda
else
    DEVICE=cpu
fi

python apps/stable_diffusion/scripts/main.py --app=txt2img --precision=fp16 --device=$DEVICE --prompt="a photograph of an astronaut riding a horse" --seed 13
