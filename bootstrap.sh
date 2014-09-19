#!/usr/bin/env bash

# To run this, you must download & install the latest Xcode and Commandline Tools
# https://developer.apple.com/xcode/
# https://developer.apple.com/downloads/

# Function to check if a package exists
check () { type -t "${@}" > /dev/null 2>&1; }

# Function to install Homebrew Formulas:
install_formula () {
  echo "Installing Homebrew Packages:"

  echo "  ➜ libyaml"
  brew install libyaml

  echo "  ➜ Install GNU Scientific Library for `rb-gsl` "
  brew install gsl

  echo "  ➜ openssl"
  brew install openssl

  echo "  ➜ git"
  brew install git

  echo "  ➜ python"
  brew install python

  echo "  ➜ node"
  brew install node

  echo "  ➜ mongodb"
  brew install mongo

  echo "  ➜ zsh"
  brew install zsh

  echo "  ➜ vim (overriding system vim)"
  brew install vim --override-system-vi

  # Cleanup
  echo "Cleaning up Homebrew intallation..."
  brew cleanup

  echo "Install Caskroom and Caskroom versions"
  brew install caskroom/cask/brew-cask
  brew tap caskroom/versions

  # Make /Applications the default location of apps
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
}


# Install Hushlogin
echo "Install hushlogin"
echo "  - Disable the system copyright notice, the date and time of the last login."
echo "    more info at @mathiasbynens/dotfiles http://goo.gl/wZBM80"
echo ""
cp -f "$HOME/.dotfiles/.hushlogin" $HOME/.hushlogin


# Install Homebrew
# ---------------------------------------------------------------------------
echo "Checking if Homebrew is installed..."

if check brew; then
  echo "Awesome! Homebrew is installed! Now updating..."
  brew upgrade
  brew update
fi

if ! check brew; then
  # Download and install homebrew
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

  # Run Brew doctor before anything else
  brew doctor
fi

# Install Homebrew Formulas
while true; do
  read -p "Would you like to install Homebrew formulas? [y/n] " answer
  case $answer in
    [y]* ) install_formula; break;;
    [n]* ) break;;
    * ) echo "Please answer Y or N.";;
  esac
done


# Install RVM
# ---------------------------------------------------------------------------

echo "Installing RVM..."
\curl -L https://get.rvm.io | bash

# Restart Terminal for RVM to take effect
echo "bootstrapping complete! quitting terminal..."
killall Terminal
