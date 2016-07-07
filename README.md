# Electron Dash docset

A repository with all you need to generate a [Dash](https://kapeli.com/dash) docset for the [electron](http://electron.atom.io) documentation.

I regularly pack electron docsets and submit them. You can download your version of choice right from Dash on your Mac: *Open Dash and go to Preferences > Downloads > User Contributed*

Instead, if you want to make yours by hand keep on reading.

## Requirements

- Python 2.7.x
- wget
- A pushbullet account (optional, only for Auto Mode, read below)

## Installation

1. clone this repo
2. `cd` into it
3. install pip dependencies running `pip install -r requirements.txt`

## How to use (Manual Mode)

This is best for manual docset generation right on your Mac.

#### Building

Execute in order:

```sh
./prepare.sh
./build.py
./pack.sh
```

- Since electron maintainers removed older doc versions from the website, you'll get the latest doc available.
- You'll found files in the `output` folder.

#### Cleaning up

After you've generated the docset and copied it where you need to, run the clean script.

```sh
./clean.sh
```

- Don't worry if you forget to clean before preparing another docset, the `prepare.sh` script will do it for you.
- Cleaning up is not done by default so you can keep the uncompressed docset file. That's useful to test it in Dash right after running the script.

#### Add it to Dash

1. Open Dash
2. Go to Preferences > Docsets
3. Click on the '+' button in the bottom-left corner and select the just-made docset

## update_checker.py (Auto Mode)

Why?

Just because electron website now keeps only the most recent doc, their development is incredibly fast and noboby wants to spend time checking their website afraid to miss a specific doc version to pack for [Dash](https://kapeli.com/dash).

The script will:

- check for and notify you via Pushbullet in case a new electron doc version is found
- run all the scripts and create the updated version of the docset
- let you know once it's done.

It's best to set it up in crontab. Example: `0 8 * * * python2 /path/to/this/repo/update_checker.py`

FYI:

- Auto Mode requires you to have a Pushbullet account and their app installed at least on one device (e.g. your smartphone). No worries, it's free!
- Notification will be sent to all your devices (so you don't have to remember to change the device_id in case you change device)

#### Setup

1. create an API token from your Pushbullet account from [here](https://www.pushbullet.com/#settings/account) and copy it
2. clone this repo and `cd` to this repo dir
3. `echo "your_token_here" > userdata/pushbullet_api_token.txt`
4. setup `crontab` (something like in the example above)
5. Done! No more need to edit files in `userdata` dir.

## Contributions

Want to contribute? Feel free to do it!

1. Fork this repo
2. Make it better
3. Send me a PR

## Credits

Thanks to Bhargav Nookala (nooknb[at]gmail[dot]com) for is input to [tidy up some things](https://github.com/bnookala/electron-dash-docset/commit/6c1ba6b95ca3d04010ea4db46451113c397c88c3) in `v1.x`.

## License

The software in this repository are released under the GNU GPLv3 License by Francesco Pira (dev[at]fpira[dot]com, fpira.com). You can read the terms of the license [here](http://www.gnu.org/licenses/gpl-3.0.html).
