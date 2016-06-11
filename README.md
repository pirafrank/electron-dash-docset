# Electron Dash docset

A repository with all you need to generate a Dash docset for the [electron](http://electron.atom.io) documentation.

## Requirements

- Python 2.7.x
- wget

## Installation

1. Fork this repo
2. `cd` into it
3. Install pip dependencies running `pip install -r requirements.txt`

## How to use

#### Building

Execute in order:

```sh
./prepare.sh
./build.py
./pack.sh
```

Since electron maintainers removed older doc versions from the website, you'll get the latest doc available.

#### Cleaning up

After you've generated the docset and copied it where you need to, run the clean script.

```sh
./clean.sh
```

## Credits

Thanks to Bhargav Nookala (nooknb[at]gmail[dot]com) for is input to [tidy up some things](https://github.com/bnookala/electron-dash-docset/commit/6c1ba6b95ca3d04010ea4db46451113c397c88c3).

## License

The software in this repository are released under the GNU GPLv3 License by Francesco Pira (dev[at]fpira[dot]com, fpira.com). You can read the terms of the license [here](http://www.gnu.org/licenses/gpl-3.0.html).
