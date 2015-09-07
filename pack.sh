#!/bin/bash

echo "copying resources into electron.docset ..."
cp res/icon* electron.docset/

echo "Start packing..."
tar --exclude='.DS_Store' -cvzf electron.tgz electron.docset
