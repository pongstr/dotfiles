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

# Home Folders
alias home="cd ~ && clear"
alias apps="/Applications"
alias documents="~/Documents"
alias movies="~/Movies/"
alias music="~/Music/"
alias pictures="~/Pictures/"
alias dropbox="/Volumes/Pongstr/Dropbox/"

# Projects Directory
alias projects="~/Projects"
alias github="~/Projects/github"
alias sandbox="~/Projects/sandbox"
alias apache="~/Projects/apache"

# Jekyll
alias jekyllstart="jekyll serve --watch --baseurl=/"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=5

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx)

source $ZSH/oh-my-zsh.sh


# Pongstr Configuration
# -----------------------------------------------------------------------------

# Export PATH after RVM installation
export PATH="/usr/local/bin:/Users/Pongstr/.rvm/gems/ruby-2.0.0-p247@global/bin:$PATH"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
