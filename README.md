Dotfiles (Pongstr)
==================

My Dotfiles for setting up OSX Workspace.

## Requirements:

  - You need to have **[Xcode](https://developer.apple.com/xcode/)** &amp; **[Xcode Command Line Tools](https://developer.apple.com/downloads)** installed.
  - You need to be an administrator (for ```sudo```).

## Usage:

Open up Terminal: **Application > Utilities > Terminal.app** and download the zipball with this command, don't include the ```$``` sign.

```shell
# Copy+Paste the curl command, this will confirm if you have Xcode and Commandline Tools installed.
# Also, it will run bootstrap.sh
$ curl -O -# https://raw.github.com/pongstr/dotfiles/wizard/install.sh && sh install.sh
```

## Editors

Mods for Terminal, Vim and Sublime Text 3
Installs Base-16 syntax highlighting color scheme and Spacegray theme for ST3

```shell
$ ./.dotfiles/editors/.terminal
```

**OSX Terminal**

![OSX Terminal with Zshell &amp; oh-my-zsh framework](http://farm4.staticflickr.com/3757/11662443365_f23de1f965_o.png)

**Vim** with Base-16 Ocean Dark color scheme

![Vim with Base-16 Ocean Dark color scheme](http://farm8.staticflickr.com/7337/11662693013_1f7e0ec158_o.png)

**Sublime Text 3** with [Theme - Spacegray](https://github.com/kkga/spacegray) by [@kkga](https://github.com/kkga)

![Sublime Text 3 with Theme - Spacegray ](http://farm4.staticflickr.com/3831/11663224596_107ca73f95_o.png)

## Acknowledgements

Inspiration and code was taken from may sources, including:

  - **[@mathiasbynens](https://github.com/mathiasbynens/) [dotfiles](https://github.com/mathiasbynens/dotfiles)**
  - **[@necolas](https://github.com/necolas/) [dotfiles](https://github.com/necolas/dotfiles)**
  - **[@cowboy](https://twitter.com/cowboy/) [dotfiles](https://github.com/cowboy/dotfiles)**
  - **[@ptb](https://github.com/ptb/) [OS X Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)**
