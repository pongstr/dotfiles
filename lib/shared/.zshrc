#!/usr/bin/sh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# MacVim as Default editor
export EDITOR=vim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pongstr"

# Aliases
alias zshconfig="vi $HOME/.zshrc"
alias ohmyzsh="cd $HOME/.oh-my-zsh"

# Projects Directory
# ---------------------------------------------------------------------------

PROJECTS="$HOME/Projects"

alias github="$PROJECTS/github"
alias sandbox="$PROJECTS/sandbox"
alias projects="$PROJECTS"

# Dev Stuff
# ---------------------------------------------------------------------------

# Python SimpleHTTPServer
alias pywebstart="python -m SimpleHTTPServer"

# MongoDB
alias mongostart="mongod --dbpath $HOME/.mongodb-data"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"s

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=10

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby terminalapp)

source $ZSH/oh-my-zsh.sh


# Configs
# -----------------------------------------------------------------------------

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Homebrew
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/sbin"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"

# To use Homebrew's directories rather than ~/.rbenv
export RBENV_ROOT="/usr/local/var/rbenv"

# Enable Rbenv shims and autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable Nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# Add the following to your shell init to set up gpg-agent automatically for every shell
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi
