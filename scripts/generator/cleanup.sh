#!/bin/bash

KEYS_DIR=/home/vagrant/keys

if rm -rf "$KEYS_DIR"; then
  echo "Keys removed from $KEYS_DIR"
else
  echo "Keys were not removed"
fi