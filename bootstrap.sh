#!/usr/bin/sh

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

  echo "  ➜ openssl"
  brew install openssl

  echo "  ➜ git"
  brew install git

  echo "  ➜ node"
  brew install node

  echo "  ➜ zsh"
  brew install zsh
  echo "  ➜ vim (overriding system vim)"
  brew install vim --override-system-vi

  # Cleanup
  echo "Cleaning up Homebrew intallation..."
  brew cleanup  
}


# Install Hushlogin
echo "Install hushlogin"
echo "  - Disable the system copyright notice, the date and time of the last login."
echo "    more info at @mathiasbynens/dotfiles http://goo.gl/wZBM80"
echo ""
cp -r ".hushlogin" $HOME/.hushlogin


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
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

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
if check rvm; then
  echo "Awesome! RVM is installed! Now updating..."
  rvm get head
  rvm reload
  rvm get stable
fi

if ! check rvm; then
  echo "Installing RVM..."
  \curl -L https://get.rvm.io | bash

  # Restart Terminal for RVM to take effect
  echo "bootstrapping complete! quitting terminal..."
  killall Terminal
fi