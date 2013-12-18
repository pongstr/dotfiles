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
$ curl -O -# https://raw.github.com/pongstr/dotfiles/wizard/.install-v2 && sh install-v2.sh
```

-----------------

#### Pongstr Setttings

```
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

-----------------

**License**


#### Copyright 2013 &copy; Pongstr Ordillo. MIT License.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

