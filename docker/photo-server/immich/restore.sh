#!/usr/bin/env bash

# Define the name of the Docker container
CONTAINER_NAME="immich_postgres"


INPUT_FILE=$1

if bzip2 -t "$INPUT_FILE" > /dev/null 2>&1; then
    echo "Input file is valid"
    DECOMPRESSED_FILE=$(bzip2 -dkfc "$INPUT_FILE" >> restore.sql)
    echo "$DECOMPRESSED_FILE"
    docker exec $CONTAINER_NAME psql -c -U postgres < restore.sql
    exit 0
else
    echo "Input file is not valid"
    exit 1
fi
