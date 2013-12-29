#!/usr/bin/sh

# To run this, you must download & install the latest Xcode and Commandline Tools
# https://developer.apple.com/xcode/
# https://developer.apple.com/downloads/

# Install Homebrew
# ---------------------------------------------------------------------------
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

# Run Brew doctor before anything else
brew doctor

# Install Homebrew Formulas:
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

# Install RVM
# ---------------------------------------------------------------------------
echo "Installing RVM..."
\curl -L https://get.rvm.io | bash

echo "bootstrapping complete! quitting terminal..."

# Restart Terminal for RVM to take effect
killall Terminal
