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

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable Nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
export PATH="$HOME/.nodenv/bin:$PATH"

# Enable PyEnv shims and autocompletion
if which pyenv > /dev/null; then eval "$(pyenv init --path)"; fi
export PATH="$HOME/.pyenv/bin:$PATH"
