#!/usr/bin/env bash

echo ""
echo "      ___       ___          ___          ___                   ___      "
echo "     /  /\     /__/\        /  /\        /  /\         ___     /  /\     "
echo "    /  /::\    \  \:\      /  /:/_      /  /:/_       /  /\   /  /::\    "
echo "   /  /:/\:\    \  \:\    /  /:/ /\    /  /:/ /\     /  /:/  /  /:/\:\   "
echo "  /  /:/~/:/_____\__\:\  /  /:/_/::\  /  /:/ /::\   /  /:/  /  /:/~/:/   "
echo " /__/:/ /://__/::::::::\/__/:/__\/\:\/__/:/ /:/\:\ /  /::\ /__/:/ /:/___ "
echo " \  \:\/:/ \  \:\~~\~~\/\  \:\ /~~/:/\  \:\/:/~/://__/:/\:\\  \:\/:::::/ "
echo "  \  \::/   \  \:\  ~~~  \  \:\  /:/  \  \::/ /:/ \__\/  \:\\  \::/~~~~  "
echo "   \  \:\    \  \:\       \  \:\/:/    \__\/ /:/       \  \:\\  \:\      "
echo "    \  \:\    \  \:\       \  \::/       /__/:/         \__\/ \  \:\     "
echo "     \__\/     \__\/        \__\/        \__\/                 \__\/     "
echo ""
echo "        ..........................................................       "
echo "        . Dotfiles 0.1.12 (Pongstr) for setting up OSX Workspace .       "
echo "        .      https://github.com/pongstr/dotfiles.git           .       "
echo "        ..........................................................       "
echo ""

# To run this, you must download & install the latest Xcode and Commandline Tools
# https://developer.apple.com/xcode/
# https://developer.apple.com/downloads/

echo ""
echo "  To run this, you must download & install the latest Xcode and Commandline Tools"
echo "    > https://developer.apple.com/xcode/"
echo "    > https://developer.apple.com/downloads/"
xcode-select --install

# Function to check if a package exists
check () { type -t "${@}" > /dev/null 2>&1; }

# Function to install Homebrew Formulas:
install_formula () {
  echo ""
  echo "Installing Homebrew Packages:"

  # Excluding this for now, not really a
  # fan of installing Java in my machine
  # echo ""
  # echo "  ➜ Android SDK"
  # brew install android-sdk

  echo ""
  echo "  ➜ libyaml"
  brew install libyaml

  echo ""
  echo "  ➜ Install GNU Scientific Library for rb-gsl"
  brew install gsl

  echo ""
  echo "  ➜ openssl"
  brew install openssl

  echo ""
  echo "  ➜ git"
  brew install git

  echo ""
  echo "  ➜ python"
  brew install python

  echo ""
  echo "  ➜ node"
  brew install node

  echo ""
  echo "  ➜ mongodb"
  brew install mongo
  mkdir $HOME/.mongodb-data

  echo ""
  echo "  ➜ zsh"
  brew install zsh

  echo ""
  echo "  ➜ vim (overriding system vim)"
  brew install vim --override-system-vi

  # Cleanup
  echo ""
  echo "Cleaning up Homebrew installation..."
  brew cleanup

  cp -R $HOME/.dotfiles/bin/shell/.bashrc $HOME/.bashrc
  cp -R $HOME/.dotfiles/bin/shell/.bash_alias $HOME/.bash_alias
  cp -R $HOME/.dotfiles/bin/shell/.bash_profile $HOME/.bash_profile

  echo "Installing Caskroom, Caskroom versions, Caskroom Fonts and Brew Services"
  brew install caskroom/cask/brew-cask
  brew tap homebrew/services
  brew tap caskroom/versions
  brew tap caskroom/fonts

  # Make /Applications the default location of apps
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  echo ""
  echo "Installing monospace fonts... "
  brew cask install font-droid-sans-mono
  brew cask install font-ubuntu
  brew cleanup
}


# Install Hushlogin
echo ""
echo "Install hushlogin"
echo "  - Disable the system copyright notice, the date and time of the last login."
echo "    more info at @mathiasbynens/dotfiles http://goo.gl/wZBM80"
echo ""
cp -f "$HOME/.dotfiles/.hushlogin" $HOME/.hushlogin


# Install Homebrew
# ---------------------------------------------------------------------------
echo ""
echo "Checking if Homebrew is installed..."

if check brew; then
  echo "Awesome! Homebrew is installed! Now updating..."
  echo ""
  brew upgrade
  brew update --all
fi

if ! check brew; then
  echo "Download and install homebrew"
  echo ""
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Run Brew doctor before anything else
  brew doctor
fi

# Install Homebrew Formulas
while true; do
  read -p "Would you like to install Homebrew formulas? [y/n] " answer
  echo ""
  case $answer in
    [y/Y]* ) install_formula; break;;
    [n/N]* ) break;;
    * ) echo "Please answer Y or N.";;
  esac
done


# Install RVM
# ---------------------------------------------------------------------------

echo ""
echo "Installing RVM and latest version of Ruby"
\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo ""
echo "  >   Update OSX SSL Certificates"
rvm osx-ssl-certs update all

echo "  >   Auto update SSL Certificates"
rvm osx-ssl-certs cron install

sleep 1
rvm reload

# Restart Terminal for RVM to take effect
echo ""
echo "bootstrapping complete! quitting terminal..."
killall Terminal
