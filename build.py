#!/usr/bin/env python

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

import os
import re
import sqlite3
from bs4 import BeautifulSoup


db = sqlite3.connect('electron.docset/Contents/Resources/docSet.dsidx')
cur = db.cursor()

try: cur.execute('DROP TABLE searchIndex;')
except: pass
cur.execute('CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);')
cur.execute('CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);')

docpath = 'electron.docset/Contents/Resources/Documents/docs/version'
subpath = 'docs/'
version = 'version'
docpath = 'electron.docset/Contents/Resources/Documents/'+subpath+version

page = open(os.path.join(docpath, 'index.html')).read()
soup = BeautifulSoup(page, "html.parser")

any = re.compile('tutorial')
for tag in soup.find_all('a', {'href': any}):
    name = tag.text.strip()
    if len(name) > 0:
        path = tag.attrs['href'].strip()
        path = subpath+version+'/'+path
        if path.split('#')[0] not in ('index.html'):
            cur.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Guide', path))
            print 'name: %s, path: %s' % (name, path)

any = re.compile('development')
for tag in soup.find_all('a', {'href': any}):
    name = tag.text.strip()
    if len(name) > 0:
        path = tag.attrs['href'].strip()
        path = subpath+version+'/'+path
        if path.split('#')[0] not in ('index.html'):
            cur.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Guide', path))
            print 'name: %s, path: %s' % (name, path)

any = re.compile('api')
for tag in soup.find_all('a', {'href': any}):
    name = tag.text.strip()
    if len(name) > 0:
        path = tag.attrs['href'].strip()
        path = subpath+version+'/'+path
        if path.split('#')[0] not in ('index.html'):
            cur.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Module', path))
            print 'name: %s, path: %s' % (name, path)

db.commit()
db.close()
