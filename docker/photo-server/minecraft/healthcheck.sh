#!/usr/bin/env bash

# shellcheck disable=SC1091
. .venv/bin/activate

python3 healthcheck.py
