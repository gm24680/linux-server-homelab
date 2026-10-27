#!/bin/bash

set -euo pipefail

SOURCE="/var/www/html"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date -u +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/nginx-$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Starting website backup..."

tar -czf "$BACKUP_FILE" -C /var/www html

echo "Backup created: $BACKUP_FILE"

echo "Verifying archive..."
tar -tzf "$BACKUP_FILE" > /dev/null

echo "SUCCESS: Backup archive verified."

echo "Removing old backups..."

mapfile -t backups < <(
    find "$BACKUP_DIR" -maxdepth 1 -type f \
        -name 'nginx-????-??-??_??-??-??.tar.gz' |
    sort -r
)

if (( ${#backups[@]} > 7 )); then
    printf '%s\0' "${backups[@]:7}" | xargs -0 -r rm --
fi

echo "Backup retention complete."
