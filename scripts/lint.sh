#!/usr/bin/env bash

# Run linter
yamllint -s -d .yamlint .
npx dclint -r docker/