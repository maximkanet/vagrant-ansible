#!/bin/bash

# Configuration
readonly DEFAULT_DIR="/home/vagrant"
readonly TARGET_DIR="${1:-$DEFAULT_DIR}"
readonly SOURCE="/vagrant/ansible"

# Logging function for consistent output
log() {
    echo -e "[SYNC]: $1"
}

# Execution
log "INFO: Starting Ansible sync to $TARGET_DIR"

if cp -r "$SOURCE" "$TARGET_DIR"; then
    log "SUCCESS: Sync completed"
else
    log "ERROR: Sync failed"
    exit 1
fi