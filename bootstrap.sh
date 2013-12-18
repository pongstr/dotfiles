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
# I know this shouldn't be here, but since .brew is the step one in these
# dotfiles installation and Terminal has to restart in order to recognize
# ```$ rvm``` command. This is temporary though will do this the right way
# when i get the time to reorganize everything :) 
# ---------------------------------------------------------------------------
\curl -L https://get.rvm.io | bash

# Restart Terminal for RVM to take effect
killall Terminal