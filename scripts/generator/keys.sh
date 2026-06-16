#!/bin/bash
HOME_DIR="/home/vagrant"
# Create ssh_keys.yml
KEYS_DIR="$HOME_DIR/keys"
SSH_KEYS_FILE="$HOME_DIR/ansible/vars/ssh_keys.yml"

mkdir -p $KEYS_DIR

echo "---" > $SSH_KEYS_FILE
echo "ssh_public_keys:" >> $SSH_KEYS_FILE

for USERNAME in "$@"; do
    KEY_PATH="$KEYS_DIR/$USERNAME"
    
    # Generate the SSH key pair (Ed25519 is standard, fast, and secure)
    # -N "" sets an empty passphrase (perfect for automated testing)
    # -q suppresses the standard ssh-keygen output art
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -q
    
    # Read the newly generated public key
    PUB_KEY=$(cat "${KEY_PATH}.pub")
    
    # Append the username and public key to the YAML file
    echo "  ${USERNAME}: \"${PUB_KEY}\"" >> "$SSH_KEYS_FILE"
    
    echo "Generated keys for user: ${USERNAME}"
done

echo ""
cat $SSH_KEYS_FILE
echo ""
echo "---"
echo "$@"
echo ""
echo "Generation completed"