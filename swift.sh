#!/bin/bash

echo -e "Version to install(eg 3.0.1): \c"
read VERSION

export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"

swiftenv --version
echo "Installing swift $VERSION"
swiftenv install $VERSION
echo "Setting global swift version"
swiftenv global $VERSION
echo "Checking swift installation:"
swift --version
