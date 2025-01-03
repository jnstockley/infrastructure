#!/usr/bin/env bash

sqlite3 /home/jackstockley/infrastructure/docker/racknerd/vaultwarden/vw-data/db.sqlite3 "VACUUM INTO '/home/jackstockley/infrastructure/docker/racknerd/vaultwarden/vw-data/db_backup/db-$(date '+%Y%m%d-%H%M').sqlite3'"
