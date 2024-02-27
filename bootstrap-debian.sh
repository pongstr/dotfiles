#!/bin/sh

sudo '
deb http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware

# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
' > /etc/apt/sources.list

sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    curl wget git firmware-linux-free build-essential \
    apt-transport-https terminator tree unzip zsh \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev


sudo apt purge --autoremove gnome-games -y

## Install OhMyZsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install nodenv
git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv

echo '
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
export PATH="$HOME/.nodenv/bin:$PATH"
' >> $HOME/.zshrc

eval "$(nodenv init -)" && $HOME/.zshrc

sleep 1
nodenv install 20.11.1
nodenv global 20.11.1

sleep 1

curl https://pyenv.run | bash

echo '
export PYENV_ROOT="$HOME/.pyenv/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
' >> $HOME/.zshrc

source $HOME/.zshrc
pyenv install 3.12
pyenv global 3.12




