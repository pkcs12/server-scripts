#!/bin/bash

sudo apt-get install make clang libicu-dev pkg-config libssl-dev libsasl2-dev libcurl4-openssl-dev uuid-dev git curl wget unzip -y

echo -e "URL to tar.gz: \c"
read URL

cd /usr/src

sudo wget $URL
sudo gunzip < $(basename $URL) | sudo tar -C / -xv --strip-components 1
sudo rm -f $(basename $URL)

#this fixes permission denied error
sudo chmod -R o+r /usr/lib/swift

echo "Testing installation..."
swift --version
