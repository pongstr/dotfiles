Dotfiles (Pongstr)
==================

My Dotfiles for setting up my OSX Workspace.

### Requirements:

  - You need to have Xcode or Xcode Command Line Tools installed.
  - You need to be an administrator (for ```sudo```).
  
### Usage:

```shell
# I like to keep my projects in ~/Projects, and just create a symlink ~/dotfiles
# just to keep it clean and/or organised.

# Create Projects directory
$ mkdir ~/Projects

# Open up Terminal: Application > Utilities > Terminal.app
# and download the zipball with this command, don't include the "$" sign.
$ curl -L -o dotfiles.tar.gz https://api.github.com/repos/pongstr/dotfiles/tarball/

# Extract files
$ tar -zxf dotfiles.tar.gz

# Move extracted folder to ~/Projects dir
$ mv pongstr-dotfiles ~/Projects/dotfiles

# Create a Symlink to ~/
$ ln -s ~/Projects/dotfiles ~/dotfiles

# If you're setting up a brand new Mac or a clean installed one, you may run
# the dotfiles in this order:

# Install Homebrew Git, NodeJS, Webkit2Png, Homebrew-Cask
# Homebrew-Cask then installs these apps: 
# Textmate2, App Cleaner, Dropbox, Firefox, Github, Chrome, 
# OpenOffice, Skype, Unarchiver and VLC Player
$ sh .brew

# Update Gem and Install Gem tools:
# Jammit, Compass-SASS, Jekyll, Foundation Front-end
$ sh ~/dotfiles/.gems

# OSX Defaults
$ sh ~/dotfiles/.osx

# My personal preferences (this is optional, you don't really need to run it).
$ sh ~/dotfiles/.pongstr

# Cleanup
$ rm -rf ~/dotfiles.tar.gz

# ...aaand we're done, Logout or restart your machine for settings to take effect.
```

### dotfiles:

- ```.brew```  installs homebrew packages and native apps.
- ```.gems```  installs gems for web development.
- ```.osx```   OSX-Mountain Lion setup and preferences.

  
```.pongstr``` personal preferences for:
  - Finder [sidebarlists, dock, terminal]
  - Sublime Text [Package Control, Keybindings, Preferences, Theme, Fonts]
  - Photoshop Workspace *work in progress



-------------------------------------------------------------------------------
                  
**Acknowledgements**

Inspiration and code was taken from may sources, including:
  
  - [@mathiasbynens](https://github.com/mathiasbynens/) [Mathias Bynens Dotfiles](https://github.com/mathiasbynens/dotfiles)
  - [@necolas](https://github.com/necolas/)             [Nicolas Gallagher](https://github.com/necolas/dotfiles)
  - [@cowboy](https://github.com/cowboy/)               [Ben Alman](https://github.com/cowboy/dotfiles)
  - [@ptb](https://github.com/ptb/)                     [ptb](https://github.com/ptb/Mac-OS-X-Lion-Setup)



-------------------------------------------------------------------------------

**License**

```
Copyright (c) Pongstr Ordillo

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
```