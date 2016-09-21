#!/bin/bash

brew_taps=(
  'homebrew/dupes'
  'homebrew/homebrew-php'
  'homebrew/services'
  'homebrew/versions'
  'caskroom/versions'
  'caskroom/fonts'
)

brew_formulas=(
  'nodenv'
  'rbenv'
)

nodes=(
  '4.5.0'
  '6.5.0'
  '0.12.15'
)

rubies=(
  '2.2.5'
  '2.3.1'
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
  fi

  printf "\n\e[0;33m    Setting node.js v${nodes} as the default global version.\n"
  nodenv global "${nodes}"

  cat > $HOME/.bash_profile <<EOF
# Enable nodenv shims and autocompletion
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi\n
EOF
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

    printf "\n\e[0;33m    Setting Ruby ${rubies} as the default global version.\n\e[0m"
    rbenv global "${rubies}"

  cat > $HOME/.bash_profile <<EOF
# Enable rbenv shims and autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
EOF
  fi
}


init () {
  echo ""
  printf "%s" $'\e[1;32m
    ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗████████╗██████╗
    ██╔══██╗██╔═══██╗████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗
    ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ██████╔╝
    ██╔═══╝ ██║   ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██╗
    ██║     ╚██████╔╝██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║
    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝\e[1;31m
        Dotfiles v0.3.0 https://github.com/pongstr/dotfiles\e[0m\n
    \e[0;34m--> Dotfiles bruh, we need your password access to your shit... \n\e[0m'

  printf "
  "
}

###############################################################################
#                     >>>>> Begin Here <<<<<
###############################################################################

init

echo "

  --> For added privacy invasion I'll need your local account's password.
"

# Ask for the administrator password upfront
# This prompt is taken from `boxen-web`, see https://github.com/boxen/boxen-web
sudo -p "     Password for sudo: " echo "     Thanks! See you in vegas sucker!"

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Create Installation Directory
echo "
  --> Where would you like to install the setup files? "
read -p  "      defaults to /opt/pongstr " install_dir

if [ -z "$install_dir"]; then
  sudo mkdir -p /opt/pongstr
  sudo chown ${USER}:staff /opt/pongstr
  git clone --depth=1 https://github.com/pongstr/dotfiles.git /opt/pongstr
  cd /opt/pongstr; pwd
else
  sudo mkdir -p $install_dir
  sudo chown ${USER}:staff /opt/$install_dir
  git clone --depth=1 https://github.com/pongstr/dotfiles.git /opt/$install_dir;
  cd /opt/$install_dir; pwd
fi


# Let the bootstrapping begin!
# Tools and dependencies has to be installed in to get commands to run.
printf "\n\e[0;1m  --> Checking to see if Homebrew is installed..."

install () {
  fn () {
    npm install
    sudo chmod +x pongstr.sh
    ./pongstr.sh install -a
    ./pongstr.sh config -a
    ./pongstr.sh editor -a
    ./lib/shared/.osx

  }

  install_taps
  install_formulas
  install_node
  install_ruby
  fn
}

if hash brew 2>/dev/null; then
  printf "
      Awesome! Homebrew is installed! Now updating...\n\e[0m"
  brew update
  brew upgrade --all
  install
else
  printf "\e[0;1m      Did not find Homebrew installation, installing it now...\e[0m\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  install
fi

echo "

  --> Cleaning up to save disk space..."
brew cleanup
brew cask cleanup
