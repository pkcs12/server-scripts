#!/bin/bash

echo "Setting up swap:"
fallocate -l 4G /swapfile
ls -lh /swapfile
echo "Changing permissions:"
sudo chmod 600 /swapfile
ls -lh /swapfile
echo "Enable swap:"
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Checking swap:"
sudo swapon -s
echo "Checking free memory:"
free -m

FILE="/etc/fstab"

#backup fstab before applying changes
cp /etc/fstab /etc/fstab.backup

echo "Making swap permanent:"

/bin/cat >>$FILE<<EOF
/swapfile   none    swap    sw    0   0
EOF

cat $FILE
