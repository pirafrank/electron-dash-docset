#!/bin/bash

echo "copying resources into electron.docset ..."
cp res/icon* electron.docset/
cp res/Info.plist electron.docset/Contents/

sleep 1

echo "Start packing..."
tar --exclude='.DS_Store' -cvzf electron.tgz electron.docset
