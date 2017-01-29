#!/usr/bin/bash

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Homebrew
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/sbin"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"

# Enable Rbenv shims and autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable Nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
