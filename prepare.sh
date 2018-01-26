#!/bin/bash

# dependencies
if [[ ! $(which "wget") ]]; then
    echo -e >&2 "\n$(tput setaf 1)This script requires wget. Please install it first.$(tput sgr0)\n"
    exit 1
fi

# check if electron website is reachable
echo "Checking internet connection..."
wget --spider https://electronjs.org > /dev/null 2>&1
if [ "$?" != 0 ]; then
    echo -e >&2 "$(tput setaf 1)Error: You're not online or electronjs.org is down. Please check and try again.$(tput sgr0)\n"
    exit 1
fi
echo "Connection is OK..."

# variables
DOMAIN="electronjs.org"
URL="https://electronjs.org/docs" # The trailing slash is extremely important!

# get dir where the script lives and dive in
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd "$SCRIPTPATH"

echo "Cleaning up old files..."
./clean.sh > /dev/null 2>&1

echo "Getting current doc version number..."
mkdir -p output
curl -s https://electronjs.org/docs | grep -o 'docs-version.*' | cut -d ">" -f2 | cut -d "<" -f1 > "output/CURRENT_VERSION"

echo "Creating docset dir..."
mkdir -p output/electron.docset/Contents/Resources/Documents

echo "Downloading documentation from electronjs.org..."
wget --header='Accept-Language: en-US' --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domain "$DOMAIN" --no-parent "$URL"
#wget --header='Accept-Language: en-US' "$URL" -O electronjs.org/docs.html

sleep 1

rm -rf electronjs.org/app*
rm -rf electronjs.org/node_modules
rm -rf electronjs.org/package.json
rm -rf electronjs.org/blog

echo "copying downloaded files to docset..."
#mv -f electronjs.org/* output/electron.docset/Contents/Resources/Documents/
cp -r electronjs.org/* output/electron.docset/Contents/Resources/Documents/

echo "Cleaning up..."
rm -rf electronjs.org
