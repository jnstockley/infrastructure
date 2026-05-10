#!/usr/bin/env bash

tofu init \
    -backend-config=address="${TF_ADDRESS:-"Set Address"}" \
    -backend-config=lock_address="${TF_ADDRESS:-"Set Address"}"/lock \
    -backend-config=unlock_address="${TF_ADDRESS:-"Set Address"}"/lock \
    -backend-config=username="${TF_USERNAME:-"Set Username"}" \
    -backend-config=password="${TF_PASSWORD:-"Set Password"}" \
    -backend-config=lock_method=POST \
    -backend-config=unlock_method=DELETE \
    -backend-config=retry_wait_min=5 \
    -reconfigure \
    -upgrade
