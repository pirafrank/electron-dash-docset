#!/bin/bash

echo "copying resources into electron.docset ..."
cp res/icon* output/electron.docset/
cp res/Info.plist output/electron.docset/Contents/

sleep 1

echo "Start packing..."
tar --exclude='.DS_Store' -cvzf output/electron.tgz output/electron.docset
