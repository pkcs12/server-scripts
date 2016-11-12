#!/bin/bash

echo "This script will install swift"

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."

# 1. copy shell script to server
# 2. make it executable and run it
scp swift.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x swift.sh; sh ./swift.sh; exit'
