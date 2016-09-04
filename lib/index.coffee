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
  .description ''
  .option '-u, --username <name>', ''
  .option '-e, --email <email>', ''
  .action (setup, options) ->
    gituser = require './gituser'

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
        else
          console.err(chlk.red 'Either the option is not available or is invalid.')
          return

cmd.parse process.argv
