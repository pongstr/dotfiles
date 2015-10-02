#!/bin/bash

printf "%s" $'\e[1;32m
  ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗████████╗██████╗
  ██╔══██╗██╔═══██╗████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗
  ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ██████╔╝
  ██╔═══╝ ██║   ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██╗
  ██║     ╚██████╔╝██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║
  ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝\e[1;31m
      Dotfiles v0.1.16 https://github.com/pongstr/dotfiles

\e[0;1m'

brew_formula () {
  if brew info "${@}" | grep "Not installed" > /dev/null; then
    echo "  --> Installing ${@}..."
    brew install "${@}"
  else
    echo "  --> ${@} is already installed."
  fi
}

install () {
  packages=(
    dnsmasq
    git
    libyaml
    mongo
    nginx
    nodenv
    openssl
    python
    rbenv
    "vim --override-system-vi"
    wget
    zsh
  )

  for pkg in "${packages[@]}"
  do
    if [ $# -eq 0 ]; then
      echo $1
      echo $pkg
    fi
    # if brew info "${pkg[@]}" | grep "Not installed" > /dev/null; then
    #   brew install "${pkg[@]}"
    # else
    #   echo "  --> ${@} is already installed."
    # fi
  done
}

install
