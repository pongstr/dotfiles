#!/bin/bash

  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

init () {
  echo ""
  printf "%s" $'\e[1;32m
    ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗████████╗██████╗
    ██╔══██╗██╔═══██╗████╗  ██║██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗
    ██████╔╝██║   ██║██╔██╗ ██║██║  ███╗███████╗   ██║   ██████╔╝
    ██╔═══╝ ██║   ██║██║╚██╗██║██║   ██║╚════██║   ██║   ██╔══██╗
    ██║     ╚██████╔╝██║ ╚████║╚██████╔╝███████║   ██║   ██║  ██║
    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝\e[1;31m
        Dotfiles v0.2.0 https://github.com/pongstr/dotfiles\e[0m\n

    \e[0;34m--> Dotfiles bruh, we need your password access to your shit... \n\e[0m'

  printf "
    Usage:

      dotfiles [parameters] [--arguments]

      Parameters:
        - casks      : installs default native apps via brew-cask
        - fonts      : installs default fonts declared from scripts/fonts
        - gitsetup   : setup for glolbal git config and setup for Github & Bitbucket SSH Keys
        - nodepkgs   : installs npm packages for the default node version
        - osxdefault : default setup for osx (for OS X >= 10.8)
        - rubygems   : installs gems for web development
        - terminal   : setup terminal to use zshell and oh-my-zshell plugin

  "
}

init

##
# @var {Array}
# @desc
#   Add your favorite homebrew taps here
#   accepts `brew tap` arguments wrapped in quotes
# example:
#   '<user/repo>'
#   '<user/repo> <URL>'
#
brewtaps=()

##
# @var {Array}
# @description Add your homebrew packages here
# accepts `brew install` arguments wrapped in quotes
# example:
#   'PACKAGE_NAME --ARGUMENTS_HERE'
#     --debug | --ignore-dependencies | --only-dependencies
#     --cc=[compiler] | --build-from-source | --force-botle
#     --devel | --HEAD
brewpkgs=(
  'sassc'
  'wget'
)

# @var {Array}
# @desc
#   Add node.js or io.js versions here
#   accepts nodejs or iojs sematic version
# example:
#   - node.js: '0.10.11'
#   - io.js:   'iojs-3.3.1'
nodes=(
  '5.0.0'
  '4.2.1'
  '0.12.7'
)

# @var {Array}
# @desc
#   Add preferred Ruby version here
#   accepts ruby versions
# example:
#   - '1.9.3-p551'
#   - 'mruby-1.1.0'
#   - 'jruby-9.0.1.0'
rubies=(
  '2.2.3'
  '1.9.3-p551'
)

#
initial_setup () {
  vimdirs () {
    dirs=(
      'backups'
      'colors'
      'swaps'
      'undo'
    )

    for dir in "${dirs[@]}"
    do
      printf "\e[0;32m       * ${dir} created for ${dir}\n\e[0m"
      mkdir -p "${HOME}/.vim/${dir}"
    done

    printf "\e[0;32m       * setup Vim run commands\n\e[0m"
    cp -f "$(pwd)/config/.vimrc" "${HOME}"

    printf "\e[0;32m       * setup Vim Pongstr Base-16 theme\n\e[0m"
    cp -f "$(pwd)/config/themes/Pongstr Base-16.vim" "${HOME}/.vim/colors"
  }

  printf "\n\e[0;34m  --> Setting up Vim workspace\n\e[0m"
  if [[ ! -d "${HOME}/.vim" ]]; then
    mkdir "${HOME}/.vim"
    vimdirs
  else
    vimdirs
  fi
  echo

  dnsresolver () {
    if [[ ! -f "/etc/resolver/dev" ]]; then
      sudo touch "/etc/resolver/dev"
      printf "\e[0;32m       * $(echo 'nameserver 127.0.0.1' | sudo tee -a '/etc/resolver/dev')\n"
      echo
    else
      sudo rm -rf "/etc/resolver/dev"
      sudo touch "/etc/resolver/dev"
      printf "\e[0;32m       * $(echo 'nameserver 127.0.0.1' | sudo tee -a '/etc/resolver/dev')\n"
      echo
    fi

  }

  printf "\n\e[0;34m  --> Setting up Reolver for dnsmasq\n\e[0m"
  if [[ ! -d "/etc/resolver" ]]; then
    sudo mkdir "/etc/resolver"
    dnsresolver
  else
    dnsresolver
  fi
}


initial_setup


brew_install () {
  local brew_install=$(brew install "${@}")
  echo $brew_install
}

brew_tap () {
  local brew_tap=$(brew tap "${@}")
  echo $brew_tap
}


install_formula () {
  printf "\n\e[0;34m  --> Initializing Homebrew Taps\n\e[0m"
  default_taps=(
    'homebrew/services'
    'jawshooah/nodenv'
    'caskroom/versions'
    'caskroom/fonts'
  )

  # Default Homebrew Taps
  for tap in ${default_taps[@]}
  do
    if [ "$(brew tap | grep -io ${tap})" == ${tap} ]; then
      printf "\e[0;32m       * Already tapped: ${tap}\n\e[0m"
    else
      printf "\e[0;32m       * Tapping [ ${tap} ]\n\e[0m"
      brew_tap ${tap}
    fi
  done

  # Custom Homebrew Taps
  if [[ "${#brewtaps[@]}" -gt 0 ]]; then
    for tap in "${brewtaps[@]}"
    do
      if [ "$(brew tap | grep -io ${tap})" == ${tap} ]; then
        printf "\e[0;32m       * Already tapped: ${tap}\n\e[0m"
      else
        printf "\e[0;32m       * Tapping [ ${tap} ]\n\e[0m"
        brew_tap ${tap}
      fi
    done
  fi

  printf "\n\e[0;34m  --> Installing Homebrew Formulas \n\e[0m"
  default_pkgs=(
    'caskroom/cask/brew-cask'
    'brews/dnsmasq.rb --build-from-source'
    'git'
    'libyaml'
    'brews/mongodb.rb --build-from-source'
    'brews/nginx.rb --build-from-source'
    'jawshooah/nodenv/nodenv'
    'node-build --HEAD'
    'openssl'
    'python'
    'rbenv'
    'brews/redis.rb --build-from-source'
    'vim --override-system-vi'
    'zsh'
  )

  # Default Homebrew Packages
  for package in "${default_pkgs[@]}"
  do
    if brew info $package | grep "Not installed" > /dev/null; then
      printf "\e[0;32m       * Installing ${package}, please wait... \e[0m"
      brew_install $package
    else
      printf  "\e[0;32m       * ${package} is already installed. \n\e[0m"
    fi
  done

  # Custom Homebrew Packages
  if [[ "${#brewpkgs[@]}" -gt 0 ]]; then
    for package in "${brewpkgs[@]}"
    do
      if brew info $package | grep "Not installed" > /dev/null; then
        printf "\e[0;32m       * Installing ${package}, please wait... \e[0m"
        brew_install $package
      else
        printf "\e[0;32m       * ${package} is already installed. \n\e[0m"
      fi
    done
  fi
}

printf "\e[0;1m  --> Checking to see if Homebrew is installed..."

if hash brew 2>/dev/null; then
  printf "
      Awesome! Homebrew is installed! Now updating...\n\e[0m"
  # brew update
  install_formula
  # brew upgrade --all
else
  printf "\e[0;1m      Did not find Homebrew installation, installing it now...\e[0m\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  install_formula
fi

printf "\n\e[0;34m  --> Reloading run commands $(source ${HOME}/.profile)\n"

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
  nodenv global "${nodes}"
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

  printf "\n\e[0;33m    Setting Ruby ${rubies} as the default global version.\n"
  rbenv global "${rubies}"
}

printf "\n\e[0;34m  --> Installing Ruby versions \n\e[0m"
if hash rbenv 2>/dev/null; then
  install_rubies
fi

printf "\e[0;34m
  Bootstrapping your  Mac is now complete, you now have the necessary tools
  to control your development enviroment.
\n\e[0m"

if [[ "${#@}" -gt 0 ]]; then
  while true; do
    case "${@}" in
      ('--atom') exec "bin/atom"; break;;
      ('--fonts') exec "bin/fonts"; break;;
      ('--casks') exec "bin/casks"; break;;
      ('--gitsetup') exec "bin/gitsetup"; break;;
      ('--rubygems') exec "bin/gem"; break;;
      ('--nodepkgs') exec "bin/npm"; break;;
      ('--osxmods') exec "bin/osx"; break;;
      ('--terminal') exec "bin/iterm"; break;;
    esac
  done
fi
