#!/bin/bash
if [ ! -f tank/test_models.py ]; then
    echo "tank/test_models.py not found, are you in the SHARK root directory?"
    exit 1
fi

if [ "$VIRTUAL_ENV" = "" ]; then
    echo "VIRTUAL_ENV is empty have you done source shark1.venv/bin/activate?"
    exit 1
fi

pytest tank/test_models.py -k "rocm"
