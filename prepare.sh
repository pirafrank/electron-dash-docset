#!/bin/bash

########################################################################
# electron-dash-docset <https://github.com/pirafrank/battery_life_extender>
# Notifies the user when plug or unplug the power cord to extend
# the overall battery life
#
# Copyright (C) 2015 Francesco Pira <dev@fpira.com>
#
# This file is part of electron-dash-docset.
#
# battery_life_extender is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# battery_life_extender is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with battery_life_extender. If not, see <http://www.gnu.org/licenses/>.
#
########################################################################

# variables
VERSION="$1"
DOMAIN="electron.atom.io"
URL="http://electron.atom.io/docs/""$VERSION""/" # The trailing slash is extremely important!

# checking passed arguments
if [[ $# != 1 ]]; then
    echo "Error: wrong number of arguments"
    echo "Usage: ./prepare.sh <doc version>"
    echo "Example: ./prepare.sh v0.31.0"
    echo ""
    echo "Check that the version syntax matches the version in the URL"
    echo "For example: If doc URL is http://electron.atom.io/docs/v0.31.0, then doc version is v0.31.0"
    exit -1
fi

echo "Creating docset dir..."
mkdir -p electron.docset/Contents/Resources/Documents

echo "Downloading documentation from electron.atom.io..."
wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domain "$DOMAIN" --no-parent "$URL"

sleep 1

mv "electron.atom.io/docs/""$VERSION" electron.atom.io/docs/version

sleep 1

echo "copying downloaded files to docset..."
cp -rf electron.atom.io/ electron.docset/Contents/Resources/Documents/

echo "Cleaning up..."
rm -rf electron.atom.io
