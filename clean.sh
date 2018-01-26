#!/bin/bash

# get dir where the script lives and dive in
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd "$SCRIPTPATH"

echo "Cleaning up..."
rm -rf electronjs.org > /dev/null 2>&1
rm -rf output/electron.docset > /dev/null 2>&1
rm output/CURRENT_VERSION > /dev/null 2>&1
echo "Done!"
