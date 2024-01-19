#!/bin/bash
#
# Expects to run in the SHARK root directory
if [ ! -f apps/stable_diffusion/scripts/main.py ]; then
    "stable diffusion not found, are you in a SHARK root directory?"
    exit 0
fi

python apps/stable_diffusion/scripts/main.py --app=txt2img --precision=fp16 --device=rocm --prompt="a photograph of an astronaut riding a horse" --seed 13
