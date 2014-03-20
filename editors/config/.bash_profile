#!/bin/bash

# Export PATH after RVM installation
export PATH="/usr/local/bin:/Users/Pongstr/.rvm/gems/ruby-2.1.0@global/bin:$PATH"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
