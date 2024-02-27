#!/usr/bin/sh

ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# MacVim as Default editor
export EDITOR=vim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pongstr"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=10

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Enable PyEnv shims and autocompletion
eval "$(/opt/homebrew/bin/brew shellenv)"
export PYENV_ROOT="$HOME/.pyenv/bin"
export PATH="$PYENV_ROOT/bin:$PATH"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
  iterm2
  node
  macos
  pip
  pyenv
  python
)

source $ZSH/oh-my-zsh.sh

# Aliases
# -----------------------------------------------------------------------------

alias zsconf=''
alias zshome=''
alias zsclear=''

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ll='ls -lsa'
alias hh='history'
alias dirs='dirs -v'
alias push='pushd'
alias pop='popd'

alias projects='$HOME/Projects'
alias github='$HOME/Projects/github'

alias npmlist='npm list -g --depth=0 2>/dev/null'
alias npmclean='find . -name "node_modules" -type d -prune -exec rm -rf '{}' +'

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
eval "$(/opt/homebrew/bin/brew shellenv)"


# Configs
# -----------------------------------------------------------------------------

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Enable Nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
export PATH="$HOME/.nodenv/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

# Iterm Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/aliens.omp.json)"

