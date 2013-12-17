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
# Also, it will run .brew
$ curl -O -# https://raw.github.com/pongstr/dotfiles/wizard/.install && sh .install
```

-----------------

If you're setting up a brand new Mac or a clean installed one, you may run the dotfiles in this order:

### Install Homebrew Stuff

```shell
# Brew Apps: Git, Node, Libyaml, OpenSSL & Brew-Cask
# NativeApps: 
# [app-cleaner, dropbox, firefox, github, chrome, canary, mamp, skype, st3, tm2 and vlc]
# RVM Installation
$ sh .brew
```

-----------------

### Install Gem Stuff

```shell
# Install Ruby 2.0.0, update certs cront install ssl-certs
# Install gems: [compass,jekyll,bootstrap-sass,zurb-foundation]
$ sh .gems
```

-----------------

### Install Custom OSX Defaults

**Word of warning:** 

```.osx``` is basically my operating system's preferences and settings
you may or may not like it, run it at your own risk. :)

```shell
# Pongstr's OSX Default Settings
# Please make sure you change "Pongstr" to your own username,
# it starts from Line:18 to Line:21
$ sh .osx
```

-----------------

### Install Personal Settings

```shell
# My personal preferences (this is optional, you don't really need to run it).
$ sh .pongstr

# Git Setup Configuration
GIT_AUTHOR_NAME="Pongstr"
GIT_AUTHOR_EMAIL="pongstr@example.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name    "$GIT_AUTHOR_NAME"
git config --global user.email   "$GIT_AUTHOR_EMAIL"
git config --global push.default simple
```

...aaand we're done, Logout or restart your machine for settings to take effect.


-----------------

### teh dotfiles:

- ```.brew```  installs homebrew packages and native apps.
- ```.gems```  installs gems for web development.
- ```.npm```   installs node package manager and packages.
- ```.osx```   OSX setup and preferences.
  
```.pongstr``` personal preferences for:
  - Finder [sidebarlists, dock, terminal]
  - Sublime Text [Package Control, Keybindings, Preferences, Theme, Fonts]

```.project``` - has been removed from dotfiles and moved to a [dedicated repository](https://github.com/pongstr/jekyll-boilerplate).

-----------------
                  
**Acknowledgements**

Inspiration and code was taken from may sources, including:

  - **[@mathiasbynens](https://github.com/mathiasbynens/) [Dotfiles](https://github.com/mathiasbynens/dotfiles)**
  - **[@necolas](https://github.com/necolas/) [Dotfiles](https://github.com/necolas/dotfiles)**
  - **[@cowboy](https://twitter.com/cowboy/) [Dotfiles](https://github.com/cowboy/dotfiles)**
  - **[@ptb](https://github.com/ptb/) [OS X Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)**

-----------------

**License**


### Copyright 2013 (c) Pongstr Ordillo. MIT LICENSE

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

