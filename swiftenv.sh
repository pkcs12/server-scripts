#!/bin/bash

echo "Installing swift"
echo "Fetching dependencies:"
#fetch minimal packages list
apt-get install clang libicu-dev -y
echo "Installing swiftenv"
#clone swiftenv
git clone https://github.com/kylef/swiftenv.git ~/.swiftenv

#backing up bashrc
cp ~/.bashrc ~/.bashrc.backup

echo '' >> ~/.bashrc
echo 'export SWIFTENV_ROOT="$HOME/.swiftenv"' >> ~/.bashrc
echo 'export PATH="$SWIFTENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(swiftenv init -)"' >> ~/.bashrc

echo "swiftenv successfully installed. Please logout and login back to apply changes"
