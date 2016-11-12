#!/bin/bash

FILE="/etc/default/locale"

#backup locale before making changes
sudo cp /etc/default/locale /etc/default/locale.backup

echo "Setting locale..."

sudo /bin/cat <<EOM >$FILE
LANG="en_US.UTF-8"
LANGUAGE="en_US"
LC_ALL="en_US.UTF-8"
EOM

cat /etc/default/locale
