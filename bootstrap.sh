#!/bin/bash

brew_taps=(
  'homebrew/dupes'
  'homebrew/homebrew-php'
  'homebrew/services'
  'homebrew/versions'
  'caskroom/cask',
  'caskroom/versions'
  'caskroom/fonts'
)

brew_formulas=(
  'openssl'
  'nodenv'
  'rbenv'
)

nodes=(
  '6.10.1'
  '7.4.0'
)

rubies=(
  '2.3.3'
  '2.4.0'
)

# Homebrew Tap Installation
install_taps () {
  for tap in ${brew_taps[@]}
  do
    if [ "$(brew tap | grep -io ${tap})" == ${tap} ]; then
      printf "\e[0;32m       * Already tapped: ${tap}\n\e[0m"
    else
      printf "\e[0;32m       * Tapping [ ${tap} ]\n\e[0m"
      brew tap ${tap}
    fi
  done
}

# Homebrew Formula Installation
install_formulas () {
  for package in "${brew_formulas[@]}"
  do
    if brew info $package | grep "Not installed" > /dev/null; then
      printf "\e[0;32m       * Installing ${package}, please wait... \e[0m\n\n"
      brew install $package
      echo
      echo
    else
      printf  "\e[0;32m       * ${package} is already installed. \n\e[0m"
    fi
  done
}

# Node.js Installation
install_node () {
  if hash nodenv 2>/dev/null; then
    for node in "${nodes[@]}"
    do
      if [ "$(nodenv versions | grep -Eio $node)" == $node ]; then
        printf "\e[0;32m       * node.js v$node is already installed...\n\e[0m"
      fi

      if [ "$(nodenv versions | grep -Eio $node)" == "" ]; then
        printf "\e[0;32m       * Installing node.js v${node}, sit back & relax\n"
        printf "         this may take a few minutes to complete..\n\e[0m"
        nodenv install $node
      fi
    done

    source $HOME/.bash_profile
    sleep 1

    printf "\n\e[0;33m    Setting node.js v${nodes} as the default global version.\n\e[0m"
    nodenv global "${nodes}"
  fi
}

# Ruby Installation
install_ruby () {
  if hash rbenv 2>/dev/null; then
    for rb in "${rubies[@]}"
    do
      if [ "$(rbenv versions | grep -Eio $rb)" == $rb ]; then
        printf "\e[0;32m       * ruby $rb is already installed...\n\e[0m"
      fi

      if [ "$(rbenv versions | grep -Eio $rb)" == "" ]; then
        printf "\e[0;32m       * Installing ruby ${rb}, sit back & relax\n"
        printf "         this may take a few minutes to complete..\n\e[0m"
        rbenv install $rb
      fi
    done

    source $HOME/.bash_profile
    sleep 1

    printf "\n\e[0;33m    Setting Ruby ${rubies} as the default global version.\n\e[0m"
    rbenv global "${rubies}"
    sleep 1
    sudo gem install bundler
  fi
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
      Dotfiles v0.3.0 https://github.com/pongstr/dotfiles\e[0m\n'

echo "
  --> For added privacy invasion I'll need your local account's password.
"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
# This prompt is taken from `boxen-web`, see https://github.com/boxen/boxen-web
sudo -p "      Password for sudo: " echo "     Thanks! See you in vegas sucker!"

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Create Installation Directory
echo "
  --> Where would you like to install the setup files? "
read -p  "      defaults to /opt/dotfiles
" INSTALL_DIR

if [ -z $INSTALL_DIR ]; then
  INSTALL_DIR="dotfiles"
fi

sudo mkdir -p /opt/$INSTALL_DIR
sudo chown ${USER}:staff /opt/$INSTALL_DIR
git clone --depth=1 https://github.com/pongstr/dotfiles.git /opt/$INSTALL_DIR

# Let the bootstrapping begin!
# Tools and dependencies has to be installed in to get commands to run.
printf "\n\e[0;1m  --> Checking to see if Homebrew is installed..."
if hash brew 2>/dev/null; then
  printf "
      Awesome! Homebrew is installed! Now updating...\n\n\e[0m"
  brew doctor && brew update && brew upgrade && brew cleanup
  sleep 1

  install_ruby
  sleep 1

  install_node
  sleep 1

  nodenv local ${nodes}
  rbenv local ${rubies}
  sleep 1

  source $HOME/.bash_profile
  osascript -e 'tell application "System Events" to log out'
  builtin logout
else
  printf "\e[0;1m
      Did not find Homebrew installation, installing it now...\e[0m\n\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor

  echo "
    --> Installing homebrew taps"
  install_taps
  install_formulas

  cp /opt/$INSTALL_DIR/lib/shared/.bashrc $HOME/.bashrc
  cp /opt/$INSTALL_DIR/lib/shared/.bash_profile $HOME/.bash_profile

  source $HOME/.bash_profile
  sleep 1

  install_node
  sleep 1

  install_ruby
  sleep 1

  nodenv local ${nodes}
  rbenv local ${rubies}

  if [ ! -d "/etc/resolver" ]; then
    sudo mkdir -p /etc/resolver
    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
  fi

  osascript -e 'tell application "System Events" to log out'
  builtin logout
fi
