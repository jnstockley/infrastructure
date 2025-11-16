#!/usr/bin/env bash

# Define the name of the Docker container
CONTAINER_NAME="postgres"

# Get the current date and time in the format YYYY-MM-DD_HH-MM-SS
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the backup directory and output file, including the current date and time in its name
OUTPUT_DIR="${HOME}/infrastructure/docker/photo-server/postgres/backup"
mkdir -p "$OUTPUT_DIR"

# Remove backups older than 14 days
find "$OUTPUT_DIR" -type f -name 'dump_*.sql.bz2' -mtime +14 -print -exec rm -f {} \;

OUTPUT_FILE="${OUTPUT_DIR}/dump_${CURRENT_DATE}.sql.bz2"

# Truncate table
docker exec $CONTAINER_NAME psql -U jackstockley -d authentik -c "TRUNCATE TABLE public.django_channels_postgres_message;"

# Run the pg_dumpall command inside the Docker container and save the output to a file
docker exec $CONTAINER_NAME pg_dumpall -U jackstockley -W | bzip2 >"$OUTPUT_FILE"
