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

echo "Cleaning up..."
rm -rf electron.docset
rm electron.tgz
echo "Done!"
