'use strict'

fs    = require 'fs'
cmd   = require 'commander'
path  = require 'path'
cson  = require 'cson'
chlk  = require 'chalk'
prmpt = require 'prompt'
conf  = cson.parseFile './config.cson'
require 'shelljs/global'

cmd
  .version '0.1.0'
  .command 'install [pkg]'
  .description 'install and setup necessary web development packages'
  .option '-a, --all',    'Install all packages declared in '
  .option '-u, --update', 'Update Package Managers (e.g., brew, cask, fonts, gem, npm).'
  .action (pkg, options) ->
    pkgFn = require './package'

    install = () ->
      if pkg and /^(brew|cask|fonts|gem|npm)$/.test(pkg)
        pkgFn.install[pkg] and pkgFn.install[pkg](conf[pkg])
      else
        pkgFn.install.all(conf)
      return

    update = () ->
      if pkg and /^(brew|cask|fonts)$/.test(pkg)
        pkgFn.update.brew()
      else if pkg and /^(all|gem|npm)$/.test(pkg)
        pkgFn.update[pkg] and pkgFn.update[pkg]()
      else
        pkgFn.update.all()
      return

    if options and options.update
      update()
      install()
      return
    else
      install()
      return
    return

cmd
  .command 'config [pkg]'
  .description ''
  .option '-a, --all', 'initialize configs for dnsmasq, mongodb, mysql, nginx and redis.'
  .action (pkg, options) ->
    configurator = require './templates/index'
    if !pkg or options and options.all
      configurator('all')
      return
    else
      configurator(pkg)
      return
    return


cmd
  .command 'git [setup]'
  .description 'Setup global Git configuration and Git provider SSH Keys'
  .option '-u, --username <name>', ''
  .option '-e, --email <email>', ''
  .action (setup, options) ->
    gituser  = require './gituser'
    home_dir = echo '~'
    config_template = "
    \nHost github.com
    \n  HostName github.com
    \n  IdentityFile #{home_dir}/.ssh/github_rsa\n
    \nHost bitbucket.org
    \n  HostName bitbucket.org
    \n  IdentityFile #{home_dir}/.ssh/bitbucket_rsa\n
    \nHost gitlab.com
    \n  HostName gitlab.com
    \n  IdentityFile #{home_dir}/.ssh/gitlab_rsa\n"

    exec "rm -rf $(echo $HOME)/.ssh/config; touch $(echo $HOME)/.ssh/config"
    fs.appendFileSync "#{home_dir}/.ssh/config", config_template, 'utf8'


    if setup == 'config' and options.username and options.email
      exec "git config --global user.name #{options.username}; git config --global #{options.email}"
      exec "git config --global push.default simple; git config --global alias.lg \"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative\""

      prmpt.start()

      console.info chlk.blue "
      \nSelect which task to run next:\n
      \n  [1] Bitbucket: Create and Add SSH Keys
      \n  [2] Github: Create and Add SSH Keys
      \n  [3] GitLab: Create and Add SSH Keys
      \n"

      prmpt.get 'select_number', (err, res) ->
        if res and parseInt(res.select_number) == 1
          gituser.git_bitbiucket()
        else if res and parseInt(res.select_number) == 2
          gituser.git_github()
        else if res and parseInt(res.select_number) == 3
          gituser.git_gitlab()
        else
          console.err(chlk.red 'Either the option is not available or is invalid.')
          return
    else
      prmpt.start()

      console.info chlk.blue "
      \nLet's get your git environment setup:\n
      \n  [0] Configure Git Username and Email address
      \n  [1] Bitbucket: Create and Add SSH Keys
      \n  [2] Github: Create and Add SSH Keys
      \n  [3] GitLab: Create and Add SSH Keys
      \n  [Q/q] Quit this menu
      \n"

      prmpt.get 'select_number', (err, res) ->
        if res and parseInt(res.select_number) == 0
          console.log chlk.blue '\n   Setup Git Contributor Username and Email:\n'
          gituser.git_config()
        else if res and parseInt(res.select_number) == 1
          console.log chlk.blue '\n   Create and Add Bitbucket SSH Key:\n'
          gituser.bitbucket()
        else if res and parseInt(res.select_number) == 2
          gituser.github()
        else if res and parseInt(res.select_number) == 3
          gituser.gitlab()
        else if res and res.select_number == 'Q' or res and res.select_number == 'q'
          console.info(chlk.green '\nOkay! Bailing Out!... (ノಠ益ಠ)ノ\n')
          return
        else
          console.error(chlk.red 'Either the option is not available or is invalid.')
          return
    return

cmd
  .command 'editor [config]'
  .description ''
  .option '-a, --all', 'Install all configs for editors.'
  .action (config, options) ->
    context = "#{path.join(__dirname, 'shared')}/"
    editor  = {}

    console.log ""

    # Atom Editor Setup
    #
    # - installs plugins declared on `config.cson`
    #   config.cson > editor > atom > plugins
    #
    # - installs configs from templates, see `config.cson`
    #   config.cson > editor > atom > config
    #
    editor.atom = () ->
      atom_conf = conf.editor.atom
      atom_home = "#{atom_conf.home_dir}/"

      if !test '-d', atom_home
        mkdir '-p', atom_home

      # Install Atom Plugins
      console.info chlk.blue "\t--> Installing Atom Plugins, please wait...\n"
      if atom_conf.plugins.length > 0
        atom_conf.plugins.forEach (plugin) ->
          exec "apm install #{plugin}"
      else
        console.info chlk.gray "\t--> No plugins declared, skipping this process\n"
      console.info chlk.green "\t--> Done!\n"

      # Install Atom Configs
      console.info chlk.blue "\t--> Installing Atom configs, please wait..."
      if atom_conf.config.length > 0
        atom_conf.config.forEach (config) ->
          cp '-f', "#{context}#{config.source}", "#{atom_home}#{config.target}"
        console.info chlk.green "\t--> Done!\n"
      else
        console.info chlk.gray "\t--> No configs declared, skipping this process\n"
      return

    # Vim Editor Setup
    #
    # - installs plugins declared on `config.cson`
    #   config.cson > editor > vim > plugins
    #
    # - installs configs declared on `config.cson`
    #   config.cson > editor > vim > config
    #
    editor.vim = () ->
      vim_conf = conf.editor.vim
      vim_home = "#{vim_conf.home_dir}/"

      if !test '-d', vim_home
        mkdir '-p', "#{vim_home}backups"
        mkdir '-p', "#{vim_home}colors"
        mkdir '-p', "#{vim_home}plugins"
        mkdir '-p', "#{vim_home}swaps"
        mkdir '-p', "#{vim_home}undo"

      # Install Vim Plugins
      console.info chlk.blue "\t--> Installing Vim plugins, please wait..."
      if vim_conf.plugins.length > 0
        vim_conf.plugins.forEach (plugin) ->
          exec "cp #{context}#{plugin} #{vim_home}plugins/#{plugin}"
      else
        console.info chlk.gray "\t--> No Vim plugins declared, skipping this process.\n"

      # Install Vim Configs
      console.info chlk.blue "\t--> Installing Vim configs, please wait..."
      if vim_conf.config.length > 0
        vim_conf.config.forEach (config) ->
          cp '-f', "#{context}#{config.source}", "#{vim_home}#{config.target}"
        console.info chlk.green "\t--> Done!\n"
      else
        console.info chlk.gray "\t--> No configs declared, skipping this process.\n"
      return

    # Terminal + oh-my-zsh setup
    #
    # - installs .oh-my-zsh and custom theme
    # - installs dotfiles
    #
    editor.term = () ->
      term_conf = conf.editor.term
      term_home = "#{term_conf.home_dir}/"

      # if !test '-d', "#{term_home}/.oh-my-zsh"
      #   console.info chlk.green "\t--> Installing oh-my-zsh plugin"
      #   exec "curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh"

      if !test '-d', "#{term_home}/.oh-my-zsh"
        console.info chlk.green "\t--> Installing oh-my-zsh plugin"
        mkdir '-p', "#{term_home}/.oh-my-zsh"


      if term_conf.config.length > 0
        console.info chlk.green "\t--> Installing Terminal configs, please wait..."
        term_conf.config.forEach (config) ->
          cp '-f', "#{context}#{config.source}", "#{term_home}#{config.target}"
        console.info chlk.green "\t--> Done!"
      else
        console.info chlk.gray "\t--> No configs declared, skipping this process."
      return

    editor.all = () ->
      @vim()
      @atom()
      @term()
      return

    if editor[config] then editor[config]() else editor.all()

cmd.parse process.argv
