#!/bin/bash
#
# Fix the pinned version of SHARK issue.
python3.11 -m pip https://github.com/llvm/torch-mlir/releases/download/snapshot-20231210.1048/torch_mlir-20231210.1048-cp311-cp311-linux_x86_64.whl
./setup_venv.sh
