Dotfiles (Pongstr)
==================

My Dotfiles for setting up OSX Workspace.

### Requirements:

-----------------

  - You need to have **[Xcode](https://developer.apple.com/xcode/)** or **[Xcode Command Line Tools](https://developer.apple.com/downloads)** installed.
  - You need to be an administrator (for ```sudo```).
  
### Usage:

-----------------

Open up Terminal: **Application > Utilities > Terminal.app** and download the zipball with this command, don't include the ```$``` sign.

```shell
# download dotfiles
$ curl -L -o dotfiles.tar.gz https://api.github.com/repos/pongstr/dotfiles/tarball/

# I like to keep my projects in ~/Projects, and just create a symlink ~/dotfiles 
# just to keep it clean and/or organised.

# Create Projects directory: 
$ mkdir ~/Projects

# Extract files:
$ tar -zxf dotfiles.tar.gz

# Move extracted folder to `~/Projects directory`
$ mv pongstr-dotfiles ~/Projects/dotfiles

# Create Symlink from '~/' direcotry
$ ln -s ~/Projects/dotfiles ~/dotfiles
```

-----------------

If you're setting up a brand new Mac or a clean installed one, you may run the dotfiles in this order:

### Install Homebrew Stuff

```shell
# Install Homebrew Git, NodeJS, Webkit2Png, Homebrew-Cask
# Homebrew-Cask then installs these apps: 
# Textmate2, App Cleaner, Dropbox, Firefox, Github, Chrome, 
# OpenOffice, Skype, Unarchiver and VLC Player
$ sh .brew
```

-----------------

### Install Gem Stuff

```shell
# Update Gem and Install Gem tools:
# Jammit, Compass-SASS, Jekyll, Foundation Front-end
$ sh .gems
```

-----------------

### Install Custom OSX Defauls

```shell
# OSX Defaults
$ sh .osx
```

-----------------

### Install Personal Settings

```shell
# My personal preferences (this is optional, you don't really need to run it).
$ sh .pongstr
```

-----------------

### Cleanup


```shell
# Cleanup
$ rm -rf ~/dotfiles.tar.gz
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
  - Photoshop Workspace *work in progress

```.project``` - has been removed from dotfiles and moved to a [dedicated repository](https://github.com/pongstr/jekyll-project).

-----------------
                  
**Acknowledgements**

Inspiration and code was taken from may sources, including:
  
  - **[Mathias Bynens Dotfiles](https://github.com/mathiasbynens/dotfiles)** - [@mathiasbynens](https://github.com/mathiasbynens/) 
  - **[Necolas dotfiles](https://github.com/necolas/dotfiles)** - [@necolas](https://github.com/necolas/)             
  - **[Cowboy dotfiles](https://github.com/cowboy/dotfiles)** - [@cowboy](https://github.com/cowboy/) 
  - **[ptb Mac OSX Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)** - [@ptb](https://github.com/ptb/)         

-----------------

**License**


### Copyright 2013 (c) Pongstr Ordillo. MIT LICENSE

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

