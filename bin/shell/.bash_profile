#!/usr/bin/sh

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
