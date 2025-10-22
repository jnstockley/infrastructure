#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE='docker/photo-server/postgres/compose.yml'
DATA_DIR='./postgres'
BACKUP_DIR="./postgres.bak.$(date +%Y%m%d%H%M%S)"
DUMP_FILE='./dump.sql'
TEMP_CONTAINER='pg17-temp'
OLD_IMAGE='postgres:17'
ENV_FILE='.env'
NEW_CONTAINER='postgres'   # matches container_name in your compose file

# read POSTGRES_USER from .env (fallback to 'postgres')
get_env_var() { grep -E "^$1=" "$ENV_FILE" 2>/dev/null | sed -E "s/^$1=//" | tr -d '\r"' || true; }
POSTGRES_USER=$(get_env_var "POSTGRES_USER")
POSTGRES_USER=${POSTGRES_USER:-postgres}

echo "1) Stopping compose stack..."
docker compose -f "$COMPOSE_FILE" down || true

echo "2) Backing up data dir to $BACKUP_DIR..."
cp -a "$DATA_DIR" "$BACKUP_DIR"

echo "3) Starting temporary Postgres $OLD_IMAGE (container: $TEMP_CONTAINER)..."
docker run --rm --name "$TEMP_CONTAINER" --env-file "$ENV_FILE" \
  -e PGDATA=/var/lib/postgresql/17/docker \
  -v "$(pwd)/postgres:/var/lib/postgresql/17/docker" \
  -p 5433:5432 -d "$OLD_IMAGE"

echo "Waiting for Postgres 17 to become ready..."
for i in $(seq 1 60); do
  if docker exec "$TEMP_CONTAINER" pg_isready -U "$POSTGRES_USER" >/dev/null 2>&1; then
    echo "Postgres 17 is ready."
    break
  fi
  sleep 1
  if [ "$i" -eq 60 ]; then
    echo "Timed out waiting for Postgres 17." >&2
    docker logs "$TEMP_CONTAINER" || true
    exit 1
  fi
done

echo "4) Dumping all databases to $DUMP_FILE..."
docker exec -i "$TEMP_CONTAINER" pg_dumpall -U "$POSTGRES_USER" > "$DUMP_FILE"

echo "5) Stopping temporary Postgres 17 container..."
docker stop "$TEMP_CONTAINER" >/dev/null || true

echo "6) Starting Postgres 18 via compose..."
docker compose -f "$COMPOSE_FILE" up -d

echo "Waiting for Postgres 18 container ($NEW_CONTAINER) to become ready..."
for i in $(seq 1 60); do
  if docker exec "$NEW_CONTAINER" pg_isready -U "$POSTGRES_USER" >/dev/null 2>&1; then
    echo "Postgres 18 is ready."
    break
  fi
  sleep 1
  if [ "$i" -eq 60 ]; then
    echo "Timed out waiting for Postgres 18." >&2
    docker logs "$NEW_CONTAINER" || true
    exit 1
  fi
done

echo "7) Restoring dump into Postgres 18..."
cat "$DUMP_FILE" | docker exec -i "$NEW_CONTAINER" psql -U "$POSTGRES_USER"

echo "Done. Verify DBs and remove $BACKUP_DIR when satisfied."
