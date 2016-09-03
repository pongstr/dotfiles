'use strict'

chlk = require 'chalk'
require 'shelljs/global'

pkg =
  update:
    brew: () ->
      console.info('😇 ', chlk.blue "Updating Homebrew and upgrading outdated packages to latest versions.")
      exec "brew update; brew upgrade --all"
    gem: () ->
      console.info('😇 ', chlk.blue "Updating Ruby Gem and upgrading outdated packages to latest versions.")
      exec "gem update --system; gem update --list"
    npm: () ->
      console.info('😇 ', chlk.blue "Updating NPM and upgrading outdated packages to latest versions.")
      exec "npm update -g npm; npm update"
    all: () ->
      console.error('😇 ', chlk.red '\n ⚠️  Woops! seems like that package manager does not exists here.\n')

  install:
    brew: (conf) ->
      exec "brew tap #{conf.taps.join(' ')}"
      if conf and conf.packages.length > 0
        conf.packages.forEach (pkg) ->
          console.info chlk.green "  --> Installing brew package: #{pkg}\n"
          exec "brew install #{pkg}"
        return 0
      return 1
    cask: (conf) ->
      if conf and conf.length > 0
        conf.forEach (pkg) ->
          console.info chlk.green "  --> Installing caskroom/cask package: #{pkg}\n"
          exec "brew cask install #{pkg}"
        return 0
      return 1

    fonts: (conf) ->
      if conf and conf.length > 0
        conf.forEach (pkg) ->
          console.info chlk.green "  --> Installing caskroom/fonts package: #{pkg}\n"
          exec "brew cask install #{pkg}"
        return 0
      return 1

    gem: (conf) ->
      if conf and conf.length > 0
        conf.forEach (pkg) ->
          console.info chlk.green "  --> Installing ruby gem: #{pkg}\n"
          exec "gem install #{pkg}"
        return
      return

    npm: (conf) ->
      if conf and conf.length > 0
        conf.forEach (pkg) ->
          console.info chlk.green "  --> Installing node package: #{pkg}\n"
          exec "npm install -g #{pkg}"
        return
      return

    all: (conf) ->
      @brew(conf.brew)
      @cask(conf.cask)
      @fonts(conf.fonts)
      @gem(conf.gem)
      @npm(conf.npm)
      return

module.exports = pkg
