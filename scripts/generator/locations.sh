#!/bin/bash
HOME_DIR="/home/vagrant"
# Create servers.yml
SERVERS_FILE="$HOME_DIR/ansible/vars/servers.yml"

echo "---" > $SERVERS_FILE
echo "servers:" >> $SERVERS_FILE

for LOCATION in "$@"; do
    read -a users -p "$LOCATION: "
    printf "%2s%s\n" "" "$LOCATION:" >> $SERVERS_FILE

    for USERNAME in "${users[@]}"; do
      printf "%4s%s\n" "" "- $USERNAME" >> $SERVERS_FILE
    done
done

echo ""
cat $SERVERS_FILE
echo ""
echo "Generation completed"