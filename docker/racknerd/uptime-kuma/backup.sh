#!/usr/bin/env bash

# Define the name of the Docker container
CONTAINER_NAME="uptime-kuma"

# Location of the database file
DATABASE_FILE="/app/data/kuma.db"

# Get the current date and time in the format YYYY-MM-DD_HH-MM-SS
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the output file, including the current date and time in its name
OUTPUT_FILE="${HOME}/infrastructure/docker/racknerd/uptime-kuma/backup/dump_${CURRENT_DATE}.sql.bz2"

# Run the pg_dumpall command inside the Docker container and save the output to a file
docker exec $CONTAINER_NAME sqlite3 $DATABASE_FILE .dump | bzip2 >"$OUTPUT_FILE"
