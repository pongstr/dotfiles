#!/usr/bin/env bash

# as of [24.03.2014], installing ruby versions will give you
# a `dyld : Library not loaded` error and the way to get through
# it is to disable binary on install:
# https://twitter.com/mpapis/status/447926386314186752

# install openssl, libyaml dependancies is installed via .brew
echo ""
echo "Installing Ruby 2.1.1"
rvm install 2.1.1 --disable-binary

sleep 1
rvm reload

echo ""
echo "  >   Set 2.1.1 as the default version"
rvm use 2.1.1 --default


# Update OSX SSL Certs
# ---------------------------------------------------------------------

sleep 1
rvm reload

echo ""
echo "  >   Update OSX SSL Certificates"
rvm osx-ssl-certs update all

echo "  >   Auto update SSL Certificates"
rvm osx-ssl-certs cron install

sleep 1


echo ""
echo "Updating Ruby Gems"
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

echo ""
echo "Cleaning up..."
gem cleanup

