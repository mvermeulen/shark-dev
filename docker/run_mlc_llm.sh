#!/bin/bash
rocm-smi
conda create --name mlc-rocm python=3.11
conda activate mlc-rocm

pip install --pre --force-reinstall mlc-ai-nightly-rocm57 mlc-chat-nightly-rocm57 -f https://mlc.ai/wheels
git lfs install
mkdir dist
cd dist
git clone https://github.com/mlc-ai/binary-mlc-llm-libs.git prebuilt_libs
git clone https://huggingface.co/mlc-ai/Llama-2-7b-chat-hf-q4f16_1-MLC
cd ..

python3 chat.py
