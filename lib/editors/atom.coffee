'use strict'

fs   = require 'fs'
path = require 'path'
chlk = require 'chalk'
cson = require 'cson'

require 'shelljs/global'

module.exports =
  init: () ->
    that        = this

    return
  config: () ->
    return "atom.config"

  styles: () ->
    return "styles.less"

  toolbar: () ->
    return "toolbar.coffee"
