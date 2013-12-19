#!/usr/bin/env bash

# To run this, you must download & install the latest Xcode and Commandline Tools
# https://developer.apple.com/xcode/
# https://developer.apple.com/downloads/

# Install Homebrew
# ---------------------------------------------------------------------------
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

# Run Brew doctor before anything else
brew doctor

# Install Homebrew Formulas:
brew install libyaml
brew install openssl
brew install git
brew install zsh
brew install node
brew install vim --override-system-vi

# Cleanup
brew cleanup

# Install RVM
# ---------------------------------------------------------------------------
\curl -L https://get.rvm.io | bash

echo "bootstrapping complete! quitting terminal..."

# Restart Terminal for RVM to take effect
killall Terminal