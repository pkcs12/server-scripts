#!/bin/bash

echo "This script will install vapor"

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."

# 1. copy shell script to server
# 2. make it executable and run it
scp vapor.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x vapor.sh; sudo sh ./vapor.sh; exit'
