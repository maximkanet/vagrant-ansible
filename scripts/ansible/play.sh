#!/bin/bash

readonly HOME_DIR="/home/vagrant"
readonly ANSIBLE_DIR="$HOME_DIR/ansible"

readonly HOSTS_FILE="$ANSIBLE_DIR/inventory/hosts.yml"
# readonly PLAYBOOK_FILE="$ANSIBLE_DIR/site.yml"
readonly PLAYBOOK_FILE="$ANSIBLE_DIR/playbooks/site.yml"

# Process flags
while getopts "hvf:s" opt; do
  case ${opt} in
    s )
      # Sync ansible files with machine
      bash /vagrant/scripts/ansible/sync.sh $HOME_DIR
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

# Go to anaible dir and run playbook
(
  cd $ANSIBLE_DIR || exit 1
  ansible-playbook -i $HOSTS_FILE $PLAYBOOK_FILE
)