import os
import sys
import urllib2
import subprocess
from bs4 import BeautifulSoup
import requests
import json

# checking if a file exists
def file_exists(file):
    return os.path.isfile(os.getcwd()+'/'+file)

# creating an empty file
def touch_version_file(file):
    with open(os.getcwd()+'/'+file, 'w') as f:
        f.close()

# read electron version since last run from file
def get_previous_electron_version(file):
    with open(os.getcwd()+'/'+file) as f:
        s = f.read().replace('\r\n', '\n').replace('\r', '\n')
        lines = s.split('\n')
        return lines[1]

# retrieve current electron doc version from electron.atom.io/docs
def get_current_electron_version(doc_url):
    response = urllib2.urlopen(doc_url)
    html = response.read()

    soup = BeautifulSoup(html, "html.parser")
    doc_version_span = soup.findAll("span", { "class" : "docs-version" })
    #current_electron_version = doc_version_span[0].string
    return doc_version_span[0].string

# update version file with given version
def update_version_file(file,version):
    with open(os.getcwd()+'/'+file, 'r+') as f:
        #f.seek(0)
        f.write('Warning: Do NOT touch this file!\n')
        f.write(version+'\n')
        f.close()

# calling scripts in folder to actually download electron docs and make the Dash docset
def updater():
    subprocess.call(["/bin/bash","./prepare.sh"])
    subprocess.call(["python2","./build.py"])
    subprocess.call(["/bin/bash","./pack.sh"])

# getting api token from file
def get_api_token(file):
    with open(os.getcwd()+'/'+file) as f:
        s = f.read().replace('\r\n', '\n').replace('\r', '\n')
        lines = s.split('\n')
        return lines[0]

# letting you know...
def notify(message):
    if file_exists(api_token_file):
        token = get_api_token(api_token_file)
    else:
        print "Error: No API token file found!"
        sys.exit()

    url = "https://api.pushbullet.com/v2/pushes"
    headers = {"Access-Token":token,"Content-Type":"application/json"}
    data = {"body":message,"title":"Electron docs Update Checker","type":"note"}

    r = requests.post(url, data=json.dumps(data), headers=headers)

if __name__ == '__main__':
    current_electron_version = get_current_electron_version("http://electron.atom.io/docs/index.html")
    print "Current electron doc version is: "+current_electron_version

    electron_version_file = "userdata/electron_vers_last_run.txt"
    api_token_file = "userdata/pushbullet_api_token.txt"

    if file_exists(electron_version_file):
        previous_electron_version = get_previous_electron_version(electron_version_file)
        print "During last run electron version was: "+previous_electron_version

        if previous_electron_version == current_electron_version:
            print "\nNo electron doc updates at this time.\nBye!\n"
            sys.exit()
        else:
            message = "\nelectron doc versions mismatch. updating...\n"
            print message
            message = message+'\n'+'Last run version was: '+previous_electron_version+'\n'+"Current electron version is: "+current_electron_version
            notify(message)

            updater()
            update_version_file(electron_version_file,current_electron_version)
            notify("All done!")
    else:
        message = "Warning: No electron version file found!\nInitializing file and redownloading docs..."
        print(message)
        message = message+'\n'+"Current electron version is: "+current_electron_version+'\n'
        notify(message)

        updater()
        touch_version_file(electron_version_file)
        update_version_file(electron_version_file,current_electron_version)
        notify("All done!")
