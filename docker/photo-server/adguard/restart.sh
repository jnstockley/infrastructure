#!/usr/bin/env bash

dir="$(pwd)"

docker compose -f "$dir/compose.yml" up -d --force-recreate --remove-orphans