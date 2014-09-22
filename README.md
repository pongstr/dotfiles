Dotfiles (Pongstr)
========

No need to use `sudo` when running these dotfiles, Just install by running the command:

```bash
$ curl -L -O https://raw.githubusercontent.com/pongstr/dotfiles/wizard/install.sh && sh install.sh
```


### Requirements

> **[Xcode](https://developer.apple.com/xcode/)** &amp; **[Xcode Command Line Tools](https://developer.apple.com/downloads)**

> `sudo` isn't necessary but it will be asked for Homebrew to be installed.


### Initialize Dotfiles

Once bootstrapped, you may run these dotfiles in this specific order:

```bash
# Install `ruby-2.1.1` and set it as default
# Update `osx-ssl-certs` & install cron to auto-update it.
# Update `gem` system
# Install gems [ rb-gsl, bundler, github-pages, compass, foundation, boostrap-sass]
$ ./.dotfiles/init/.ruby


# Install `npm` and packages [bower, express, grunt-cli, jshint, less]
$ ./.dotfiles/init/.npm


# Install `casks` and tap to `caskroom-versions`
$ ./.dotfiles/init/.casks


# Install Sublime Text 3, Package Control, Spacegray Theme and Sublime Text Packages
$ ./.dotfiles/init/.subl


# Guide that helps you setup your git configuration and ssh-key setup for Github and Bitbucket
$ ./.dotfiles/init/.gituser


# Install oh-my-zsh, Pongstr Base-16.terminal theme, oh-my-zsh theme and configs
$ ./.dotfiles/init/.shell


# Setup vim
$ ./.dotfiles/init/.vim


# Make OSX awesome
$ ./.dotfiles/init/.osx
```

Terminal, Vim &amp; Sublime Text
-------

**OSX Terminal**

![OSX Terminal with Zshell &amp; oh-my-zsh framework](http://farm4.staticflickr.com/3757/11662443365_f23de1f965_o.png)

**Vim** with Base-16 Ocean Dark color scheme

![Vim with Base-16 Ocean Dark color scheme](http://farm8.staticflickr.com/7337/11662693013_1f7e0ec158_o.png)

**Sublime Text 3** with [Theme - Spacegray](https://github.com/kkga/spacegray) by [@kkga](https://github.com/kkga)

![Sublime Text 3 with Theme - Spacegray ](http://farm4.staticflickr.com/3831/11663224596_107ca73f95_o.png)

#### Acknowledgements

Inspiration and code was taken from may sources, including:

  - [@mathiasbynens](https://github.com/mathiasbynens/) [dotfiles](https://github.com/mathiasbynens/dotfiles)
  - [@necolas](https://github.com/necolas/) [dotfiles](https://github.com/necolas/dotfiles)
  - [@cowboy](https://twitter.com/cowboy/) [dotfiles](https://github.com/cowboy/dotfiles)
  - [@ptb](https://github.com/ptb/) [OS X Lion Setup](https://github.com/ptb/Mac-OS-X-Lion-Setup)
