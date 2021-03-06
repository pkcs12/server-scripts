#!/bin/bash

echo "This script will install swiftenv and swift."

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Installing..."
# 1. copy shell script to server
# 2. make it executable and run it
scp swiftenv.sh swiftenv-swift.sh $USERNAME@$IP:/home/$USERNAME
ssh -t $USERNAME@$IP 'chmod +x swiftenv.sh; chmod +x swiftenv-swift.sh; sh ./swiftenv.sh && sh ./swiftenv-swift.sh; exit'
