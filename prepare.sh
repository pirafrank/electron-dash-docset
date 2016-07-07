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

# get dir where the script lives and dive in
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd "$SCRIPTPATH"

echo "Cleaning up old files..."
./clean.sh > /dev/null 2>&1

echo "Getting current doc version number..."
mkdir -p output
curl -s http://electron.atom.io/docs/index.html | grep -o 'docs-version.*' | cut -d ">" -f2 | cut -d "<" -f1 > "output/CURRENT_VERSION"

echo "Creating docset dir..."
mkdir -p output/electron.docset/Contents/Resources/Documents

echo "Downloading documentation from electron.atom.io..."
wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domain "$DOMAIN" --no-parent "$URL"

sleep 1

echo "copying downloaded files to docset..."
mv -f electron.atom.io/* output/electron.docset/Contents/Resources/Documents/

echo "Cleaning up..."
rm -rf electron.atom.io
