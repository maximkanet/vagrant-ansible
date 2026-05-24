#!/bin/bash

HOME_DIR="/home/vagrant"
ANSIBLE_DIR="$HOME_DIR/ansible"

HOSTS_FILE="$ANSIBLE_DIR/inventory/hosts.yml"
SITE_FILE="$ANSIBLE_DIR/site.yml"

# Go to anaible dir and run playbook
(
  cd $ANSIBLE_DIR || exit 1
  ansible-playbook -i $HOSTS_FILE $SITE_FILE
)