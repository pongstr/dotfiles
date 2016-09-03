'use strict'

fs    = require 'fs'
cmd   = require 'commander'
path  = require 'path'
cson  = require 'cson'
chlk  = require 'chalk'
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

cmd.parse process.argv
