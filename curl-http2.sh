#!/bin/bash

echo "Installing dependencies for nghttp2..."
sudo apt-get update
sudo apt-get install g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev cython python3-dev python-setuptools -y

echo "Cloning latest nghttp2..."
cd ~/
git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2

echo "Building nghttp2..."

autoreconf -i
automake
autoconf
./configure
make
sudo make install
sudo ldconfig

echo "Checking installed package..."
if sudo ldconfig -v | grep http2 ; then
    echo "nghttp2 installed."
else
    echo "Failed to install nghttp2."
    exit
fi

rm -rf ~/nghttp2

echo "Installing dependencies for curl:"
sudo apt-get install build-essentials -y

echo "Cloning latest curl..."
cd ~/
sudo git clone https://github.com/curl/curl.git
#sudo wget https://curl.haxx.se/download/curl-7.51.0.tar.bz2
#sudo tar -xvjf curl-7.51.0.tar.bz2
#cd curl-7.51.0
cd curl

echo "Building curl..."

sudo ./buildconf
./configure --help

sudo ./configure --with-ssl --with-nghttp2 --enable-verbose --enable-ipv6

sudo make
sudo make install
sudo ldconfig

#this fixes the problem:
#vapor: /usr/local/lib/libcurl.so.4: no version information available (required by /usr/lib/swift/linux/libFoundation.so)
sudo ln -fs /usr/lib/libcurl.so.4 /usr/local/lib/

echo "Testing installation..."
line=$(curl -V | grep HTTP2)
if [[ "$line" =~ ^$ ]]; then
    echo "Failed to install curl with http/2"
    exit
else
    echo "curl with http/2 installed"
fi
#if [[ $(curl -V | grep HTTP2) ]]; then
#    echo "curl with http/2 installed"
#else
#    echo "Failed to install curl with http/2"
#    exit
#fi

rm -rf ~/curl

echo "Making test request..."
curl --http2 -I https://google.com
