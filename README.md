Dotfiles (Pongstr)
========

version `0.1.15`

### Requirements

**[Xcode](https://developer.apple.com/xcode/)** &amp; **[Command Line Tools](https://developer.apple.com/downloads)**

> `sudo` is necessary for Homebrew to be installed and for some others. To get started run these commands:

```bash
# download latest from Github
$ curl -L -O https://github.com/pongstr/dotfiles/archive/0.1.15.zip

# unzip the file and move to $HOME directory
unzip 0.1.15.zip && mv dotfiles-0.1.15 ~/.dotfiles

# run bootstrap!
sh ~/.dotfiles/bootstrap.sh
```


### Initialize Dotfiles

```bash
# Install `npm` and packages [bower, express, grunt-cli, jshint, less]
$ ./.dotfiles/init/.npm


# Update `gem` and install gems [rails, bundler, github-pages]
$ ./.dotfiles/init/.gems


# Install `casks` and tap to `caskroom-versions`
$ ./.dotfiles/init/.casks


# Install Sublime Text 3, Package Control, Spacegray Theme and Sublime Text Packages
$ ./.dotfiles/init/.subl


# Install Atom and Packages
$ ./.dotfiles/init/.atom


# Guide that helps you setup your git configuration and ssh-key setup for Github and Bitbucket
$ ./.dotfiles/init/.gituser


# Install oh-my-zsh, Pongstr Base-16.terminal theme, oh-my-zsh theme and configs
$ ./.dotfiles/init/.shell


# Setup vim, make it extra awesome..
$ ./.dotfiles/init/.vim


# OSX optimal awesome settings
$ ./.dotfiles/init/.osx


# Install fonts for coding and docs
$ ./.dotfiles/init/.fonts
```

### Sublime, Vim, ZShell

Modified version of [spacegray](http://github.com/kkga/spacegray.git)

![Pongstr Spacegray](http://i.imgur.com/ejGME1z.png)


Terminal and Zshell Theme

> #### HEADS UP!
> Once the theme has loaded, you might want to replace the shell's startup command
> from `login -fpql pongstr /bin/zsh` to `login -fpql YOURNAME /bin/zsh`
> from Preferences, under Profiles > Shell tab

![Terminal and Zshell Theme](http://i.imgur.com/Wc9hZiw.png)

Vim Base-16 Color scheme

![Vim Base-16 Color scheme](http://i.imgur.com/ZORdYxI.png)

#### Acknowledgements

Inspiration and code was taken from many sources, including:

  - [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
  - [@necolas](https://github.com/necolas/dotfiles)
  - [@cowboy](https://twitter.com/cowboy/dotfiles/)
  - [@ptb](https://github.com/ptb/Mac-OS-X-Lion-Setup)
