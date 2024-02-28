#!/bin/bash

brew_formulas=(
  curl
  gpg-suite
  gpg-agent
  git
  gh
  httpie
  pinentry-mac
  postgresql@16
  neovim
  nodenv
  pyenv
  wget
  zlib
)

brew_casks=(
  appcleaner
  bitwarden
  brave-browser
  discord
  firefox
  firefox-developer-edition
  google-chrome
  google-chrome-canary
  iina
  istat-menus
  iterm2
  pgadmin4
  slack
  spotify
  transmission
  visual-studio-code
)

brews() {
  for package in "${brew_formulas[@]}"; do
    if brew info $package | grep "Not installed" >/dev/null; then
      printf "\e[0;32m       * Installing ${package}, please wait... \e[0m\n\n"
      brew install $package
      echo
      echo
    else
      printf "\e[0;32m       * ${package} is already installed. \n\e[0m"
    fi
  done
}

casks() {
  for package in "${brew_casks[@]}"; do
    printf "\e[1;32m\nInstalling \e[1;34m$package\e[0m\n"
    echo ""
    brew install --cask $package
  done
}

###############################################################################
#                     >>>>> Begin Here <<<<<
###############################################################################

echo ""
printf "%s" $'\e[1;32m
  ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗████████╗██████╗
  ██╔══██╗██╔═══██╗████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗
  ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ██████╔╝
  ██╔═══╝ ██║   ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██╗
  ██║     ╚██████╔╝██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║
  ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝\e[1;31m
      Dotfiles v0.5.0 https://github.com/pongstr/dotfiles\e[0m\n'

echo "
  --> For added privacy invasion I'll need your local account's password.
"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
# This prompt is taken from `boxen-web`, see https://github.com/boxen/boxen-web
sudo -p "      Password for sudo: " echo "      Thanks! See you in vegas sucker!"

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

touch .hushlogin

echo "
  --> Where would you like to install the setup files? "
read -p "      defaults to /opt/dotfiles
      " INSTALL_DIR

if [ -z $INSTALL_DIR ]; then
  INSTALL_DIR="dotfiles"
fi

sudo mkdir -p /opt/$INSTALL_DIR
sudo chown ${USER}:staff /opt/$INSTALL_DIR
git clone --depth=1 --branch=main https://github.com/pongstr/dotfiles.git /opt/$INSTALL_DIR

if hash brew 2>/dev/null; then
  printf "
      Awesome! Homebrew is installed! Now updating...\n\n\e[0m"
  brew doctor && brew update && brew upgrade && brew cleanup
else
  printf "\e[0;1m
      Did not find Homebrew installation, installing it now...\e[0m\n\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew doctor

  brews
  casks

  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono
  brew jandedobbeleer/oh-my-posh/oh-my-posh
fi

if hash omz 2>/dev/null; then
  printf "
      Installing OhMyZSH...\n\n\e[0m"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  curl -L -o $HOME/.oh-my-zsh/themes/pongstr.zsh-theme https://raw.githubusercontent.com/pongstr/dotfiles/main/.omzsh/pongstr.zsh-theme
  cp $INSTALL_DIR/.zshrc $HOME/.zshrc
else
  omz update
  curl -L -o $HOME/.oh-my-zsh/themes/pongstr.zsh-theme https://raw.githubusercontent.com/pongstr/dotfiles/main/.omzsh/pongstr.zsh-theme
  cp $INSTALL_DIR/.zshrc $HOME/.zshrc
fi

if hash nvim 2>/dev/null; then
  printf "
      Setting up NeoVim...\n\n\e[0m"

  git clone https://github.com/pongstr/kickstart.nvim.git $HOME/.config/nvim
  nvim --headless "+Lazy! sync" +qa
  nvim +'checkhealth' +qa
fi

if hash pyenv 2>/dev/null; then
  printf "
      Setting up Python...\n\n\e[0m"
  pyenv install 3.12
  pyenv global 3.12
fi

if hash nodenv 2>/dev/null; then
  printf "
      Setting up Node...\n\n\e[0m"
  nodenv install 20.11.1
  nodenv global 20.11.1
fi

if hash git 2>/dev/null; then
  printf "
      Setting up Git Config...\n\n\e[0m"
  ./gitconfig.sh
fi

