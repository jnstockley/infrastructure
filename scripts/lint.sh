#!/usr/bin/env bash

# Run linter
yamllint -s .
npx dclint -r --max-warnings 0 docker/