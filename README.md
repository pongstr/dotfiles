Dotfiles (Pongstr)
==================

My Dotfiles for setting up OSX Workspace.

### Requirements:

  - You need to have **[Xcode](https://developer.apple.com/xcode/)** &amp; **[Xcode Command Line Tools](https://developer.apple.com/downloads)** installed.
  - You need to be an administrator (for ```sudo```).
  
### Usage:

-----------------

Open up Terminal: **Application > Utilities > Terminal.app** and download the zipball with this command, don't include the ```$``` sign.

```shell
# Copy+Paste the curl command, this will confirm if you have Xcode and Commandline Tools installed.
# Also, it will run bootstrap.sh
$ curl -O -# https://raw.github.com/pongstr/dotfiles/wizard/install-v2.sh && sh install-v2.sh
```

-----------------

#### bootstrap.sh

```shell 
# Installs my personal development essentials [libyaml openssl, git, zsh, node and vim (newer version that overrides osx default)]
# after installations are done, it will killall Terminal so rvm command will take effect.

sh bootstrap.sh
```

#### bin/osxdefaults

```shell
# Installs OSX GUI preferences but does not change critical stuff.

sh ~/dotfiles/bin/osxdefaults
```

#### bin/casks

```shell
# Installs native apps via homebrew-cask
# [ app-cleaner, dropbox, firefox, github, chrome, chrome-canary, mamp, skype ]
# [ st3, tm2, trim-enabler, viber, vlc, virutalbox ]

sh ~/dotfiles/bin/casks
```

#### bin/rvm

```shell
# Installs Ruby 2.0.0, updates OSX SSL Certs and crons its install to stay healthy
# You might want to run this before bin/gems otherwise you might get some errors with
# installing gems' documentation or something.
  
sh ~/dotfiles/bin/rvm
```

#### bin/gems

```shell
# Installs Jekyll, Compass, Zurb Foundation & Bootstrap-Sass
# You might want to run bin/rvm before running this just to be safe from errors.

sh ~/dotfiles/bin/ruby
```

#### bin/npm

```shell
# Installs node package manager and packages such as
# [bower, expressjs, grunt-cli and less]

sh ~/dotfiles/bin/npm
```




-----------------

#### Modern.IE Virtual Boxes

```shell
# Windows7 - IE8 Virtualbox
curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE8_Win7/IE8.Win7.For.MacVirtualBox.part{1.sfx,2.rar,3.rar,4.rar,5.rar,6.rar}"

# Windows7 IE9 Virtualbox
curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE9_Win7/IE9.Win7.For.MacVirtualBox.part{1.sfx,2.rar,3.rar,4.rar,5.rar}"

# Windows7 IE10 Virtualbox
curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE10_Win7/IE10.Win7.For.MacVirtualBox.part{1.sfx,2.rar,3.rar,4.rar}"

# Windows8 IE10
curl -O "https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/OSX/IE10_Win8/IE10.Win8.For.MacVirtualBox.part{1.sfx,2.rar,3.rar}"
```

-----------------
                  
**Acknowledgements**

Inspiration and code was taken from may sources, including:

  - **[@mathiasbynens](https://github.com/mathiasbynens/) [dotfiles](https://github.com/mathiasbynens/dotfiles)**
  - **[@necolas](https://github.com/necolas/) [dotfiles](https://github.com/necolas/dotfiles)**
  - **[@cowboy](https://twitter.com/cowboy/) [dotfiles](https://github.com/cowboy/dotfiles)**
  - **[@ptb](https://github.com/ptb/) [OS X Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)**
