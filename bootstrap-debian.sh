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
    libreadline-dev libsqlite3-dev wget curl libncurses-dev \
    fd-find xz-utils libffi-dev liblzma-dev nvidia-driver

sudo apt purge --autoremove gnome-games -y

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

lazygit --version

## Install OhMyZsh
echot ""
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install OhMyPosh
echo ""
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

curl -L -o $HOME/Downloads/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
sudo mkdir /usr/share/fonts/JetBrainsMono && unzip $HOME/Downloads/JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMono
sudo fc-cache -f -v

eval "$(oh-my-posh init zsh --config $HOME/.poshthemes/aliens.omp.json)"

## Install Neovim
echo ""
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

sleep 1

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> $HOME/.zshrc

git clone https://github.com/pongstr/kickstart.nvim.git $HOME/.config/nvim

nvim --headless "+Lazy! sync" +qa
nvim +'checkhealth' +qa

## Install pyenv
echo ""
curl https://pyenv.run | bash

echo '
export PYENV_ROOT="$HOME/.pyenv/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
' >> $HOME/.zshrc

source $HOME/.zshrc
pyenv install 3.12
pyenv global 3.12

sleep 1

## Install go
curl -L -O https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
rm go1.22.0.linux-amd64.tar.gz

## Install nodenv
echo ""
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
source $HOME/.zshrc

## create plugins directory
mkdir -p "$(nodenv root)"/plugins

## install must-have plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update
git clone https://github.com/nodenv/node-build-update-defs.git "$(nodenv root)"/plugins/node-build-update-defs
git clone https://github.com/ouchxp/nodenv-nvmrc.git $(nodenv root)/plugins/nodenv-nvmrc

## Install Firefox (non-esr)
curl -L -o $HOME/Downloads/firefox-stable.tar.bz2 https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US
sudo tar -C /opt -xvf $HOME/Downloads/firefox-stable.tar.bz2
sudo touch /usr/share/applications/firefox.desktop
sudo echo '[Desktop Entry]
Name=Firefox Stable
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true' > /usr/share/applications/firefox.desktop
rm $HOME/Downloads/firefox-stable.tar.bz2


## Install Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser

