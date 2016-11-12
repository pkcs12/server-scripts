#!/bin/bash

echo "This script will install curl with http/2 support."

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."

scp curl-http2.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x curl-http2.sh; sudo sh ./curl-http2.sh; exit'
