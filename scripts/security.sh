#!/usr/bin/env bash

docker pull checkmarx/kics:alpine
docker run -t -v .:/infrastructure checkmarx/kics:alpine scan -p /infrastructure -o "/infrastructure/" --exclude-queries d6355c88-1e8d-49e9-b2f2-f8a1ca12c75b,1c1325ff-831d-43a1-973e-839ae57dfcc0,bc2908f3-f73c-40a9-8793-c1b7d5544f79,8c978947-0ff6-485c-b0c2-0bfca6026466,ce76b7d0-9e77-464d-b86f-c5c48e03e22d,555ab8f9-2001-455e-a077-f2d0f41e2fb9
