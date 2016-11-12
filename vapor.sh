#!/bin/bash
curl -sL "check.vapor.sh" | bash || exit 1;

DIR=".vapor-toolbox-temporary";

sudo rm -rf $DIR;

sudo mkdir -p $DIR
cd $DIR;

echo "Downloading...";
sudo git clone https://github.com/vapor/toolbox vapor-toolbox > /dev/null 2>&1;
cd vapor-toolbox;

TAG=$(git describe --tags);
sudo git checkout $TAG > /dev/null 2>&1;

echo "Compiling...";
sudo swift build -c release > /dev/null;

echo "Installing...";
sudo .build/release/Executable self install;

cd ../../;
sudo rm -rf $DIR;

echo 'Use vapor --help and vapor <command> --help to learn more.';
