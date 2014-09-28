Dotfiles (Pongstr)
========

version `0.1.0`

### Requirements

> **[Xcode](https://developer.apple.com/xcode/)** &amp; **[Xcode Command Line Tools](https://developer.apple.com/downloads)**

> `sudo` isn't necessary but it will be asked for Homebrew to be installed.


### Initialize Dotfiles

Once bootstrapped, you may run these dotfiles in this specific order:

```bash
# Install `ruby-2.1.1` and set it as default
# Update `osx-ssl-certs` & install cron to auto-update it.
$ ./.dotfiles/init/.rvm

# You may need to execute `.rvm` first before `.gems` as it
# will set the default version of ruby and all that stuff in
# order to install your gems
$ ./.dotfiles/init/.gems


# Install `npm` and packages [bower, express, grunt-cli, jshint, less]
$ ./.dotfiles/init/.npm


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


# Setup vim
$ ./.dotfiles/init/.vim


# Make OSX awesome
$ ./.dotfiles/init/.osx

# Install fonts for coding and docs
$ ./.dotfiles/init/.fonts
```

### Sublime, Vim, ZShell

Modified version of [spacegray](http://github.com/kkga/spacegray.git)

![Pongstr Spacegray](http://i.imgur.com/ejGME1z.png)


Terminal and Zshell Theme

![Terminal and Zshell Theme](http://i.imgur.com/Wc9hZiw.png)

Vim Base-16 Color scheme

![Vim Base-16 Color scheme](http://i.imgur.com/ZORdYxI.png)

#### Acknowledgements

Inspiration and code was taken from may sources, including:

  - [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
  - [@necolas](https://github.com/necolas/dotfiles)
  - [@cowboy](https://twitter.com/cowboy/dotfiles/)
  - [@ptb](https://github.com/ptb/Mac-OS-X-Lion-Setup)
