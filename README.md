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
$ curl -O -# https://raw.github.com/pongstr/dotfiles/wizard/install.sh && sh install.sh
```

-----------------

#### bootstrap.sh

```shell 
# Installs my personal development essentials [libyaml openssl, git, zsh, node and vim (newer version that overrides osx default)]
# after installations are done, it will killall Terminal so rvm command will take effect.

sh bootstrap.sh
```

#### editors/

```shell
# Mods for Terminal, Vim and Sublime Text 3
# Installs Base-16 syntax highlighting color scheme and Spacegray theme for ST3

$ sh shell.sh
```


-----------------
                  
**Acknowledgements**

Inspiration and code was taken from may sources, including:

  - **[@mathiasbynens](https://github.com/mathiasbynens/) [dotfiles](https://github.com/mathiasbynens/dotfiles)**
  - **[@necolas](https://github.com/necolas/) [dotfiles](https://github.com/necolas/dotfiles)**
  - **[@cowboy](https://twitter.com/cowboy/) [dotfiles](https://github.com/cowboy/dotfiles)**
  - **[@ptb](https://github.com/ptb/) [OS X Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)**
