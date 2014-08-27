#!/usr/bin/env bash

# as of [24.03.2014], installing ruby versions will give you
# a `dyld : Library not loaded` error and the way to get through
# it is to disable binary on install:
# https://twitter.com/mpapis/status/447926386314186752

# install openssl, libyaml dependancies is installed via .brew
rvm install 2.1.1 --disable-binary
rvm reload
rvm use 2.1.1 --default

# Update OSX SSL Certs
# ---------------------------------------------------------------------
rvm reload
rvm osx-ssl-certs update all

# Stay Healthy, automate updating of certs
rvm osx-ssl-certs cron install

# Update Gem System
gem update --system

# Install Gems Tools
# ----------------------------------------------------------------------

function installgem () {
  if ! gem spec "${@}" > /dev/null 2>&1; then
    echo "Installing ${@}..."
    gem install "${@}"
  else
    echo "${@} is already installed"
  fi
}

installgem rb-gsl
installgem bootstrap-sass
installgem bundler
installgem compass
installgem foundation
installgem github-pages
installgem rails
