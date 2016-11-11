#!/bin/bash

echo "Installing dependencies and nghttp2:"
sudo apt-get update
sudo apt-get install g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev cython python3-dev python-setuptools

cd /usr/local/src
sudo git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2
sudo autoreconf -i
sudo automake
sudo autoconf
sudo ./configure
sudo make
sudo make install

echo "Checking installed package:"
ldconfig -v | grep http2

echo "Installing dependencies and curl:"
sudo apt-get install build-essentials curl

cd /usr/local/src
sudo wget https://curl.haxx.se/download/curl-7.51.0.tar.bz2
tar -xvjf curl-7.51.0.tar.bz2
cd curl-7.51.0

sudo ./buildconf
./configure --help

sudo ./configure --with-ssl --with-nghttp2 --enable-verbose --enable-ipv6

sudo make
sudo make install
sudo ldconfig

echo "Testing installation:"
curl -V
curl --http2 -I https://google.com
