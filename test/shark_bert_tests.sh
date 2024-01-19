#!/bin/bash
pytest tank/test_models.py -k "rocm and bert and base"
pytest tank/test_models.py -k "rocm and bert and large"
