'use strict'

require('shelljs/global')

const fs = require('fs')
const cmd = require('commander')
const path = require('path')
const cson = require('cson')
const chalk = require('chalk')
const prompt = require('prompt')
const config = cson.parseFile('./config.cson')
const pkg = require('../package.json')

const desc = `
  Options with commander are defined with the .option() method, also serving as
  documentation for the options. The example below parses args and options from
  process.argv, leaving remaining args as the program.args array which were not
  consumed by options.`

cmd
  .version(pkg.version)
  .description(desc)
  .usage('[options]')
  .option('-p, --package    [type]',  'installs the package types declared in `config.cson`.', require('./package'))
  .option('-e, --editors    [name]',  'setup text editors, IDE, terminal and all that jazz.', require('./editor'))
  .option('-g, --gitconfig  [conf]',  'setup global git config and provider SSH and GPG keys.', require('./gitconfig'))
  .parse(process.argv)
