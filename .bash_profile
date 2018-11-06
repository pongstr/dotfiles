#!/usr/bin/bash

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -lsa'
alias hh='history'
alias dirs='dirs -v'
alias push='pushd'
alias pop='popd'

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Homebrew
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/sbin"

# Enable Rbenv shims and autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable Nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
