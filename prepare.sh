#!/bin/bash

# dependencies
if [[ ! $(which "wget") ]]; then
    echo -e >&2 "\n$(tput setaf 1)This script requires wget. Please install it first.$(tput sgr0)\n"
    exit 1
fi

# check if electron website is reachable
echo "Checking internet connection..."
wget --spider http://electron.atom.io > /dev/null 2>&1
if [ "$?" != 0 ]; then
    echo -e >&2 "$(tput setaf 1)Error: You're not online or electron.atom.io is down. Please check and try again.$(tput sgr0)\n"
    exit 1
fi
echo "Connection is OK..."

# variables
DOMAIN="electron.atom.io"
URL="http://electron.atom.io/docs/" # The trailing slash is extremely important!

echo "Creating docset dir..."
mkdir -p electron.docset/Contents/Resources/Documents

echo "Downloading documentation from electron.atom.io..."
wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domain "$DOMAIN" --no-parent "$URL"

sleep 1

echo "copying downloaded files to docset..."
cp -rf electron.atom.io/ electron.docset/Contents/Resources/Documents/

echo "Cleaning up..."
rm -rf electron.atom.io
