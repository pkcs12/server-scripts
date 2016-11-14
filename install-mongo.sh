#!/bin/bash

echo "This script will install swiftenv and swift."

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."

scp mongo.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x mongo.sh; sudo sh mongo.sh; exit'
