# GitHub Repository Backup

This repository contains a script and crontab entry that can be used
to maintain copies of one or more repositories at GitHub.


## Prerequisites

This script was will run in any environment that can provide the following:

 * A POSIX-compliant Bourne shell and standard command-line tools
 * The [cURL](https://curl.haxx.se) command-line interface
 * The [jq](https://stedolan.github.io/jq) scripting language

**Note that the `install` target in the Makefile uses Linux-specific commands.**


## Installation

1. Create a dedicated user account for this program to use.  Do not use a
shared account, as the installation and removal process will clobber
the user's crontab. (You may, of course, skip the `make install` step
below and install the crontab yourself.)

1. Become that user.

1. Clone this repository into a subdirectory of the user's home directory (`git clone https://github.com/markfeit/github-backup.git`).

1. `make install`.  Note that this does not install any files outside the
soure directory other than the crontab which runs it.


## Configuration

### Repo List

1. Edit the `repos` file and add repositories as directed in the
comments.

Repositories backed up by this program will appear in the `archive` directory.


### Access Token

**NOTE:** This step is optional but strongly recommended.  Without an
access token, the program will be confined to GitHub's [API rate
limits](https://developer.github.com/v3/#rate-limiting).  Each
repository backed up generates eight API calls and any entry in the
repository list that requires listing a user's repositories generates one.

1. [Create a personal access token](https://github.com/settings/tokens)
using your GitHub account.  Give this token the minimum possible
access (i.e., do not check any of the scope boxes.)

1. Create a file called `auth` in the directory where the sources were
unpacked and add one line with your GitHub username and the token
separated by a colon (e.g.,
`someuser:784eac6a358a602121ae98eedeadbeef1badcafe`).

1. Set the permissions to user-only read (`chmod 400 auth`).


## Removal

1. `make uninstall` In the directory where the sources were unpacked.
