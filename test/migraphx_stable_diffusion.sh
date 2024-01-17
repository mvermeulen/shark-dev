#!/bin/bash
#
# Expects to run in the MIGraphX root directory.
#
cd examples/diffusion/python_stable_diffusion_21

# set up python environment
python3 -m venv sd_venv
source sd_venv/bin/activate
pip install -r requirements.txt

# Set up python module path
export PYTHONPATH=/src/AMDMIGraphX/build/lib:$PYTHONPATH

# Fetch the model
optimum-cli export onnx --model stabilityai/stable-diffusion-2-1 models/sd21-onnx

# Run the text-to-image script
python txt2img.py --prompt "a photograph of an astronaut riding a horse" --seed 13 --output astro_horse.jpg
