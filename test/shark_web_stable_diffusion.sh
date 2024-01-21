#!/bin/bash
#
# Expects to run in the root shark directory
if [ -d apps/stable_diffusion/web ]; then
    echo "apps/stable_diffusion/web not found are you in the SHARK directory?"
    exit 1
fi

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "VIRTUAL_ENV is empty have you done source shark1.venv/bin/activate?"
    exit 1
fi

cd apps/stable_diffusion/web
python index.py
