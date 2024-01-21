#!/bin/bash
if [ -d /opt/rocm ]; then
    pytest tank/test_models.py -k "rocm and bert and base"
    pytest tank/test_models.py -k "rocm and bert and large"
elif [ -d /usr/local/cuda ]; then
    pytest tank/test_models.py -k "cuda and bert and base"
    pytest tank/test_models.py -k "cuda and bert and large"    
else
    pytest tank/test_models.py -k "bert and base"
    pytest tank/test_models.py -k "bert and large"    
fi
