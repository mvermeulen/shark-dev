#!/bin/bash
#
# Work around the pinned version of SHARK issue.
# Run this first and then retry the setup_venv.sh script.
# Switch to python3.11 to do the pip install
update-alternatives --set python3 /usr/bin/python3.11
pip3 install https://github.com/llvm/torch-mlir/releases/download/snapshot-20231210.1048/torch_mlir-20231210.1048-cp311-cp311-linux_x86_64.whl
PYTHON=python3.11 ./setup_venv.sh
update-alternatives --set python3 /usr/bin/python3.10
