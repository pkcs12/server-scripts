#!/bin/bash

echo -e "Server IP: \c"
read IP
echo -e "Username: \c"
read USERNAME

echo "Install swiftenv"
# 1. copy shell script to server
# 2. make it executable and run it
scp ./swiftenv.sh $USERNAME@$IP:/home/$USERNAME/swiftenv.sh
ssh -t $USERNAME@$IP 'chmod +x swiftenv.sh; sudo sh ./swiftenv.sh; sudo systemctl reload sshd; exit'

echo "Install swift"
# 1. copy shell script to server
# 2. make it executable and run it
scp ./swift.sh $USERNAME@$IP:/home/$USERNAME/swift.sh
ssh -t $USERNAME@$IP 'chmod +x swift.sh; sudo sh ./swift.sh; exit'
