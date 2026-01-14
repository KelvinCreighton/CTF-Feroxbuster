# feroxbust.sh

A small Bash utility that automates directory enumeration with **feroxbuster**, aggregates multiple wordlists, captures discovered URLs, and searches responses for a user provided CTF flag pattern.

## Features

- Combines all wordlists in a single directory into one unique, sorted list
- Runs `feroxbuster` against a target URL
- Extracts discovered URLs and saves them to `urls.txt`
- Automatically curls each discovered URL
- Searches responses for a specified flag format
- Fails fast on errors (`pipefail`, curl timeouts)


### Wordlists
The common.txt is provided in the download as well as my own growing wordlist.
Feel free to add more wordlists to the ./wordlists directory
