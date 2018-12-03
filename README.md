Dotfiles (Pongstr) `0.5.0b`
===

Please make sure **Xcode** and **Xcode Command line tools** are installed and have been initialized.

### Bootstrapping

The command below will `cURL` the bootstrap file and install [homebrew](https://brew.sh/) which is
the key to all of these.

```bash
# Download bootstrap and run it
$ curl -L -o bootstrap.sh https://raw.githubusercontent.com/pongstr/dotfiles/master/bootstrap.sh \
  && chmod +x bootstrap.sh \
  && ./bootstrap.sh
```

You will then be prompted to enter your password as a pre-requisite to create directories
and install stuff, it's gonna take a few minutes depending on your internet speed.

In addition to bootstrapping, it also installs these run commands for bash shell to get
nodenv and rbenv working:

- `.bashrc`
- `.bash_profile `
- `.macos`

and will eventually log yout out for optimum awesome. Once you've logged back in, you may now install
packages and a webdev env simply by running the command below and be greeted with a prompt:

```bash
$ cd /opt/dotfiles && ./pongstr
```

![Dotfiles](https://i.imgur.com/TerhqiG.png)

> There's more option than what the image shows.

#### Adding/Removing Packages

> **ℹ️ Before running `./pongstr` command**<br>
> You may customise the `formulas`, `casks`, `gems` or `npm` packages that will be installed by modifying
> the file [`pongstr.packages`](https://github.com/pongstr/dotfiles/blob/master/pongstr.packages)

```bash
brew_taps=(
  ## Additional Homebrew taps
  "homebrew/services"
)

brew_formulas=(
  ## Homebrew Formulas
  "nginx "
)

brew_casks=(
  ## Homebrew Casks here
  "nginx --with-http2 --with-gunzip"
  "vim --with-override-system-vi"
  ...
)

ruby_gems=(
  ## Ruby Gems
  "bundler"
  ...
)

node_packages=(
  ## Node Packages
  "@vue/cli"
  "express-generator"
  "typescript"
  ...
)
```

### Git Setup

```bash
## Setup global git config
$ ./.gituser/setup

## Setup Github SSH-Keys
#  an option to automatically upload the ssh-key to github requires a personal access token
$ ./.gituser/github
```
