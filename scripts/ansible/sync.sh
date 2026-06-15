#!/bin/bash
HOME_DIR="$1"

(
echo "Ansible syncing: Syncing starting ..."
cp -r /vagrant/ansible $HOME_DIR
echo "Ansible syncing: Done"
)