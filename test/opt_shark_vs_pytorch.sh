#!/bin/bash
cd tank/examples/opt
python opt_perf_comparison.py --max-seq-len=512 --model-name=facebook/opt-1.3b --platform=shark
python opt_perf_comparison.py --max-seq-len=512 --model-name=facebook/opt-1.3b --platform=huggingface
