#!/bin/bash

# get dir where the script lives and dive in
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd "$SCRIPTPATH"

echo "copying resources into electron.docset ..."
cp res/icon* output/electron.docset/
cp res/Info.plist output/electron.docset/Contents/

# get version of the packed docset
DOCSET_VERSION=$(cat "output/CURRENT_VERSION" | head -n1)

sleep 1

echo "Start packing..."
mkdir -p output/$DOCSET_VERSION
cd output
tar --exclude='.DS_Store' -cvzf $DOCSET_VERSION/electron.tgz electron.docset
