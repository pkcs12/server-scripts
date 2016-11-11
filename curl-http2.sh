#!/bin/bash

echo "Installing dependencies for nghttp2..."
sudo apt-get update
sudo apt-get install g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev cython python3-dev python-setuptools -y

echo "Cloning latest nghttp2..."
cd /usr/local/src
sudo git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2

echo "Building nghttp2..."

sudo autoreconf -i
sudo automake
sudo autoconf
sudo ./configure
sudo make
sudo make install
sudo ldconfig

echo "Checking installed package..."
if sudo ldconfig -v | grep http2 ; then
    echo "nghttp2 installed."
else
    echo "Failed to install nghttp2."
    exit
fi

echo "Installing dependencies for curl:"
sudo apt-get install build-essentials curl -y

echo "Cloning latest curl..."
cd /usr/local/src
sudo git clone https://github.com/curl/curl.git
#sudo wget https://curl.haxx.se/download/curl-7.51.0.tar.bz2
sudo tar -xvjf curl-7.51.0.tar.bz2
cd curl-7.51.0

echo "Building curl..."

sudo ./buildconf
./configure --help

sudo ./configure --with-ssl --with-nghttp2 --enable-verbose --enable-ipv6

sudo make
sudo make install
sudo ldconfig

echo "Testing installation..."
if [[ $(curl -V | grep HTTP2) ]] ; then
    echo "curl with http/2 installed"
else
    echo "Failed to install curl with http/2"
    exit
fi

echo "Making test request..."
curl --http2 -I https://google.com
