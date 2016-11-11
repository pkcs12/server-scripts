#!/bin/bash

echo "Version to install(eg 3.0.1):"
read VERSION

swiftenv --version
echo "Installing swift $VERSION"
swiftenv install $VERSION
echo "Setting global swift version"
swiftenv global $VERSION
echo "Checking swift installation:"
swift --version
