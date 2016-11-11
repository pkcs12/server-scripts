#!/bin/bash

echo "This script will install curl with http/2 support."

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."

scp curl.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x curl.sh; sudo sh ./curl.sh; exit'
