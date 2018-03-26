#!/usr/bin/env python

import os
import sys
import re
import sqlite3
from bs4 import BeautifulSoup

def build_tutorial_index(soup, cursor):
    any = re.compile('tutorial')
    for tag in soup.find_all('a', {'href': any}):
        name = tag.text.strip()

        if len(name) > 0:
            path = tag.attrs['href'].strip()
            if "://" in path:
                return
            path = subpath+path

            if path.split('#')[0] not in ('index.html'):
                cursor.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Guide', path))
                print 'name: %s, path: %s' % (name, path)

def build_development_index(soup, cursor):
    any = re.compile('development')
    for tag in soup.find_all('a', {'href': any}):
        name = tag.text.strip()

        if len(name) > 0:
            path = tag.attrs['href'].strip()
            if "://" in path:
                return
            path = subpath+path

            if path.split('#')[0] not in ('index.html'):
                cursor.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Guide', path))
                print 'name: %s, path: %s' % (name, path)

def build_api_index(soup, cursor):
    any = re.compile('api')
    for tag in soup.find_all('a', {'href': any}):
        name = tag.text.strip()

        if len(name) > 0:
            path = tag.attrs['href'].strip()
            if "://" in path:
                return
            path = subpath+path

            if path.split('#')[0] not in ('index.html'):
                cursor.execute('INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?,?,?)', (name, 'Module', path))
                print 'name: %s, path: %s' % (name, path)

if __name__ == '__main__':
    # getting the folder where the script lives
    abs_work_path = os.path.abspath(os.path.dirname(sys.argv[0]))

    # Set up sqlite db
    db = sqlite3.connect(os.path.join(abs_work_path,'output/electron.docset/Contents/Resources/docSet.dsidx'))
    cursor = db.cursor()

    # Drop search table if it already exists
    try:
        cursor.execute('DROP TABLE searchIndex;')
    except:
        pass

    # Create search table
    cursor.execute('CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);')
    cursor.execute('CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);')

    subpath = 'docs/'
    docpath = abs_work_path+'/output/electron.docset/Contents/Resources/Documents/'+subpath

    page = open(os.path.join(docpath, 'index.html')).read()
    soup = BeautifulSoup(page, "html.parser")

    build_tutorial_index(soup, cursor)
    build_development_index(soup, cursor)
    build_api_index(soup, cursor)

    # Make db changes permanent
    db.commit()
    db.close()
