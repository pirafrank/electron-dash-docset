# Electron Dash docset

A repository with all you need to generate a Dash docset for the [electron](http://electron.atom.io) documentation.

### Requirements

- Python 2.7.x (dunno if it works on Python 3)
- Beautiful Soup 4.4.x
- wget

### Instructions

Execute in order:

```sh
./prepare.sh (doc version)
./build.py
./pack.sh
```

Please note that 'doc version' has to match the version in the URL.

Example:

The URL is ```http://electron.atom.io/docs/v0.31.0```

```sh
./prepare.sh v0.31.0
./build.py
./pack.sh
```

### License

The software in this repository are released under the GNU GPLv3 License by Francesco Pira (dev[at]fpira[dot]com, fpira.com). You can read the terms of the license [here](http://www.gnu.org/licenses/gpl-3.0.html).
