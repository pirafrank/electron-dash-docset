#!/bin/bash

# get dir where the script lives and dive in
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd "$SCRIPTPATH"

echo "copying resources into electron.docset ..."
cp res/icon* output/electron.docset/
cp res/Info.plist output/electron.docset/Contents/

# get version of the packed docset
VERSION=$(cat "output/CURRENT_VERSION" | head -n1)

sleep 1

echo "Start packing..."
mkdir -p output/$VERSION
tar --exclude='.DS_Store' -cvzf output/$VERSION/electron.tgz output/electron.docset
