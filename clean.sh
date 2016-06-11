#!/bin/bash

echo "Cleaning up..."
rm -rf electron.docset > /dev/null 2>&1
rm electron.tgz > /dev/null 2>&1
echo "Done!"
