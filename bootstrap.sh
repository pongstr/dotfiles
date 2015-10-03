#!/bin/bash

printf "%s" $'\e[1;32m
  ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗████████╗██████╗
  ██╔══██╗██╔═══██╗████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗
  ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ██████╔╝
  ██╔═══╝ ██║   ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██╗
  ██║     ╚██████╔╝██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║
  ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝\e[1;31m
      Dotfiles v0.1.16 https://github.com/pongstr/dotfiles\e[0m\n
'

brewtaps=(
  'homebrew/services'
  'jawshooah/nodenv'
  'caskroom/versions'
  'caskroom/fonts'
)

nodes=(
  '4.1.1'
  '0.12.7'
  '0.10.11'
)

packages=(
  'caskroom/cask/brew-cask'
  'dnsmasq'
  'git'
  'libyaml'
  'mongo'
  'nginx'
  'jawshooah/nodenv/nodenv'
  '--HEAD node-build'
  'openssl'
  'python'
  'rbenv'
  'sassc'
  'wget'
  'vim --override-system-vi'
  'zsh'
)

rubies=(
  '2.2.3'
  '1.9.3-p551'
)


brew_install () {
  local brew_install=$(brew install $1 $2 $3)
  echo $brew_install
}

brew_tap () {
  local brew_tap=$(brew tap $1 $2)
  echo $brew_tap
}


install_formula () {


  printf "\n\e[0;34m  --> Initializing Taps ${tap}\n\e[0m"

  for tap in ${brewtaps[@]}
  do
    if [ "$(brew tap | grep -i ${tap})" == ${tap} ]; then
      printf "\e[0;32m       * Already tapped: ${tap}\n\e[0m"
    else
      printf "\e[0;32m       * Tapping [ ${tap} ]\n\e[0m"
      brew_tap ${tap}
    fi
  done

  printf "\n\e[0;34m  --> Installing Homebrew Formulas \n\e[0m"

  for package in "${packages[@]}"
  do
    if brew info $package | grep "Not installed" > /dev/null; then
      printf "\e[0;32m       * Installing ${package}, please wait... \e[0m"
      brew_install $package
    else
      printf  "\e[0;32m       * ${package} is already installed. \n\e[0m"
    fi
  done
}

printf "\e[0;1m  --> Checking to see if Homebrew is installed..."

if hash brew 2>/dev/null; then
  printf "
      Awesome! Homebrew is installed! Now updating...\n\e[0m"
  # brew update
  install_formula
  # brew upgrade --all
else
  printf '\e[0;1m      Did not find Homebrew installation, installing it now...\e[0m\n'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  install_formula
fi

printf "\n  --> Reloading run commands $(source ${HOME}/.profile)\n"

install_nodes () {
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

  printf "\n\e[0;33m    Setting node.js v${nodes} as the default global version.\n"
}

printf "\n\e[0;34m  --> Installing Node.js versions \n\e[0m"
if hash nodenv 2>/dev/null; then
  install_nodes
fi

install_rubies () {
  for rb in "${rubies[@]}"
  do
    if [ "$(rbenv versions | grep -Eio $rb)" == $rb ]; then
      printf "\e[0;32m       * ruby $rb is already installed...\n\e[0m"
    fi

    if [ "$(rbenv versions | grep -Eio $rb)" == "" ]; then
      printf "\e[0;32m       * Installing ruby $rb}, sit back & relax\n"
      printf "         this may take a few minutes to complete..\n\e[0m"
      rbenv install $rb
    fi
  done

  printf "\n\e[0;33m    Setting Ruby ${rb} as the default global version.\n"
}

printf "\n\e[0;34m  --> Installing Ruby versions \n\e[0m"
if hash rbenv 2>/dev/null; then
  install_rubies
fi

printf "\e[0;34m
  Bootstrapping your  Mac is now complete, you now have the necessary tools
  to control your development enviroment.

\e[0m"
