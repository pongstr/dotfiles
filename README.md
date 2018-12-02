Dotfiles (Pongstr) `0.5.0b`
===

Please make sure **Xcode** and **Xcode Command line tools** are installed and have been initialized.

### Bootstrapping

```bash
# Download bootstrap and run it
$ curl -L -o bootstrap.sh https://raw.githubusercontent.com/pongstr/dotfiles/master/bootstrap.sh \
  && chmod +x bootstrap.sh \
  && ./bootstrap.sh
```

The `bootstrap.sh` files sets up homebrew and the base homebrew packages this set up depends on.
These packages are:

**Homebrew Taps**

```bash
brew_taps=(
  'homebrew/services'
  'caskroom/cask',
  'caskroom/versions'
  'caskroom/fonts'
)
```

You may edit [this line](https://github.com/pongstr/dotfiles/blob/master/bootstrap.sh#L3) to
add/remove taps.

**Homebrew Formulas**

```bash
brew_formulas=(
  'golang'
  'nodenv'
  'openssl'
  'pyenv'
  'rbenv'
  'tmux'
  'zsh'
)
```

You may edit [this line](https://github.com/pongstr/dotfiles/blob/master/bootstrap.sh#L10) to
add/remove formulas.


**Nodejs versions**

```bash
nodes=(
  '10.13.0' # On bootstrap, this index will be set as the default global version
  '6.14.4'
)
```

You may edit [this line](https://github.com/pongstr/dotfiles/blob/master/bootstrap.sh#L18) to
add/remove node versions.

**Ruby versions**

```bash
rubies=(
  '2.5.1' # On bootstrap. this index will be set as the default global version
)
```

You may edit [this line](https://github.com/pongstr/dotfiles/blob/master/bootstrap.sh#L23) to
add/remove ruby versions.

In addition to bootstrapping, it also installs these run commands for bash shell to get
nodenv and rbenv working:

- `.bashrc`
- `.bash_profile `
- `.tmux.config`

[OhMyZsh](https://github.com/robbyrussell/oh-my-zsh) is also installed to add extra awesome `zsh`.

### Installing Packages

After bootstrapping, changedir to `/opt/dotfiles` where this project is cloned, and execute these
commands to install more brew formulas, casks, gems and npm packages:

> **⚠️ Before running these commands**<br>
> You may customise the formulas, casks, gems or npm packages that will be installed by modifying
> the file [`pongstr.packages`](https://github.com/pongstr/dotfiles/blob/master/pongstr.packages)

```bash
# Just run this bash script :)
$ ./pongstr
```

![Dotfiles](https://i.imgur.com/TerhqiG.png)

### Git Setup

```bash
## Setup global git config
$ ./.gituser/setup

## Setup Github SSH-Keys
#  an option to automatically upload the ssh-key to github requires a personal access token
$ ./.gituser/github
```
