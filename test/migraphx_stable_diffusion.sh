#!/bin/bash
#
# Expects to run in the MIGraphX root directory.
#
if [ ! -d examples/diffusion/python_stable_diffusion_21 ]; then
    "stable diffusion not found, are you in a MIGRaphX root directory?"
    exit 0
fi

cd examples/diffusion/python_stable_diffusion_21

# Create a cached environment for the ONNX files
if [ -d /root/.cache/onnx -a ! -d models ]; then
    mkdir -p /root/.cache/onnx/migx_stable_diffusion
    ln -s /root/.cache/onnx/migx_stable_diffusion/models
fi

# set up python environment
python3 -m venv sd_venv
source sd_venv/bin/activate
pip install -r requirements.txt

# Set up python module path
export PYTHONPATH=/src/AMDMIGraphX/build/lib:$PYTHONPATH

# Fetch the model
if [ ! -d models/sd21-onnx ]; then
    optimum-cli export onnx --model stabilityai/stable-diffusion-2-1 models/sd21-onnx
fi

# Run the text-to-image script
python txt2img.py --prompt "a photograph of an astronaut riding a horse" --seed 13 --output astro_horse.jpg
