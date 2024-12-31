#!/usr/bin/env bash

docker run -t -v .:/infrastructure checkmarx/kics:alpine scan -p /infrastructure -o "/infrastructure/" --exclude-queries d6355c88-1e8d-49e9-b2f2-f8a1ca12c75b,1c1325ff-831d-43a1-973e-839ae57dfcc0,ce76b7d0-9e77-464d-b86f-c5c48e03e22d,bc2908f3-f73c-40a9-8793-c1b7d5544f79