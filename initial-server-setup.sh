#!/bin/bash

echo "This script will make initial setup for new server."

echo -e "Please type server IP.\r\nNOTE: you should have publickey installed on server for root user.\r\nServer IP: \c"
read IP

echo "Setting default locale"
# 1. copy shell script to server
# 2. make it executable and run it
scp ./locale.sh root@$IP:/root/locale.sh
ssh root@$IP 'chmod +x locale.sh; sh ./locale.sh'

echo "Setting swap file"
# 1. copy shell script to server
# 2. make it executable and run it
scp ./swap.sh root@$IP:/root/swap.sh
ssh root@$IP 'chmod +x swap.sh; sh ./swap.sh'


echo "Creating new user"
echo -e "Username: \c"
read USERNAME
# 1. create user with specified password
# 2. add user to sudo group
# 3. make bash default shell

SCRIPT="useradd -b /home -g users -m -p $(read -sp Password: pw; echo $pw | openssl passwd -crypt -stdin) $USERNAME; usermod -aG sudo $USERNAME; usermod -s /bin/bash $USERNAME; echo ''; exit"
if ssh root@$IP $SCRIPT ; then
    echo "User $USERNAME created"
else
    echo "Failed to create user $USERNAME"
    exit
fi

echo "Copy ssh-key to root@$IP's known_hosts"
if ssh-copy-id root@$IP ; then
    echo "Copied for root"
else
    echo "Failed to copy ssh key for root"
    exit
fi

echo "Copy ssh-key to $USERNAME@$IP's known_hosts"
SCRIPT="mkdir -p /home/$USERNAME/.ssh; chmod 700 /home/$USERNAME/.ssh; cp /root/.ssh/authorized_keys /home/$USERNAME/.ssh/authorized_keys; chmod 600 /home/$USERNAME/.ssh/authorized_keys; chown -R $USERNAME /home/$USERNAME/.ssh"
if ssh root@$IP $SCRIPT ; then
    echo "Copied for $USERNAME"
else
    echo "Failed to copy ssh key for $USERNAME"
    exit
fi

CONFIG="/etc/ssh/sshd_config"
# 1. backup sshd_config
# 2. append few flags
# 3. enable firewall with one rule for OpenSSH
SCRIPT="cp $CONFIG $CONFIG.backup; echo '' >> $CONFIG; echo '# Disabling password authentication' >> $CONFIG; echo 'PasswordAuthentication no' >> $CONFIG; echo 'PubkeyAuthentication yes' >> $CONFIG; ufw app list; ufw allow OpenSSH; ufw enable; systemctl reload sshd; exit"
if ssh root@$IP $SCRIPT ; then
    echo "Password authentication disabled"
else
    echo "Failed to disable password authentication"
    exit
fi

echo "Checking login as $USERNAME"
if ssh $USERNAME@$IP 'echo "Logged in"; exit' ; then
    echo "Success. Everything seems to be fine"
else
    echo "Failed. Something went wrong"
    exit
fi

echo "Now run 'ssh $USERNAME@$IP' to login as $USERNAME, and do rest of initialization."
