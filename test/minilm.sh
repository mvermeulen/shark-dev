#!/bin/bash
#
# Note: This seems to hang in mlir-compile?
#
# minilm example from web
curl -O https://raw.githubusercontent.com/nod-ai/SHARK/main/shark/examples/shark_inference/minilm_jit.py
#Install deps for test script
pip install transformers torch --extra-index-url https://download.pytorch.org/whl/nightly/cpu
python ./minilm_jit.py --device="vulkan"  #use cuda or vulkan or metal
