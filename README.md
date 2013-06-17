Dotfiles (Pongstr)
==================

My Dotfiles for setting up my OSX Workspace.

### Requirements:

  - You need to have Xcode or Xcode Command Line Tools installed.
  - You need to be an administrator (for ```sudo```).
  
### Usage:

Open up Terminal: Application > Utilities > Terminal.app
and download the zipball with this command, don't include the "$" sign.
```shell
$ curl -L -o dotfiles.tar.gz https://api.github.com/repos/pongstr/dotfiles/tarball/
```

```shell
# I like to keep my projects in ~/Projects, and just create a symlink ~/dotfiles
# just to keep it clean and/or organised.

# Create Projects directory
$ mkdir ~/Projects
```

```shell
# Extract files
$ tar -zxf dotfiles.tar.gz
```

```shell
# Move extracted folder to ~/Projects dir
$ mv pongstr-dotfiles ~/Projects/dotfiles
```

```shell
# Create a Symlink to ~/
$ ln -s ~/Projects/dotfiles ~/dotfiles
```

If you're setting up a brand new Mac or a clean installed one, you may run the dotfiles in this order:

```shell
# Install Homebrew Git, NodeJS, Webkit2Png, Homebrew-Cask
# Homebrew-Cask then installs these apps: 
# Textmate2, App Cleaner, Dropbox, Firefox, Github, Chrome, 
# OpenOffice, Skype, Unarchiver and VLC Player
$ sh .brew
```

```shell
# Update Gem and Install Gem tools:
# Jammit, Compass-SASS, Jekyll, Foundation Front-end
$ sh ~/dotfiles/.gems
```

```shell
# OSX Defaults
$ sh ~/dotfiles/.osx
```

```shell
# My personal preferences (this is optional, you don't really need to run it).
$ sh ~/dotfiles/.pongstr
```

```shell
# Cleanup
$ rm -rf ~/dotfiles.tar.gz
```

...aaand we're done, Logout or restart your machine for settings to take effect.


### dotfiles:

- ```.brew```  installs homebrew packages and native apps.
- ```.gems```  installs gems for web development.
- ```.npm```   installs node package manager and packages.
- ```.osx```   OSX-Mountain Lion setup and preferences.
  
```.pongstr``` personal preferences for:
  - Finder [sidebarlists, dock, terminal]
  - Sublime Text [Package Control, Keybindings, Preferences, Theme, Fonts]
  - Photoshop Workspace *work in progress

```.project``` - Initialise front-end web project using either [Bootstrap 2.3.2](http://twitter.github.io/bootstrap/) or [Foundation 4.2.1](http://foundation.zurb.com) front-end files and directories in this structure:
  
```html
. [Project Directory]
└── [assets]
  | └── [css]
  | ├── [fonts]
  | ├── [img]
  | └── [js]
  ├── config.rb   # => [configuration file for foundation]
  └── index.html
```

this also comes as a separate [gist](https://gist.github.com/pongstr/5725667).

  
**Dependancies:**

  - [git](http://git-scm.com)
  - [nodejs](http://nodejs.org) and [node package manager](https://npmjs.org)
  - [bower](http://bower.io)
  - [Less CSS Compiler](http://lesscss.org) installs via npm for compiling less stylesheets
  - [Compass/Sass](http://compass-style.org) for compiling sass stylesheets
 

**Usage:**

Just edit ```projects.sh line:6``` to target your Projects folder and run: ```$ sh projects.sh``` and it will guide you through the process.

If you have custom installation of bower and its packages, your may modify ```projects.sh line:7``` to target the directory where packages are installed, the scrip will also copy components from there.


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
