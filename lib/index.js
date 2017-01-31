'use strict'

require('shelljs/global')

const cmd = require('commander')
const chalk = require('chalk')

module.exports = (pkg) => {
  const r = chalk.red,
        g = chalk.green,
        b = chalk.blue,
        y = chalk.yellow,
        c = chalk.cyan

  const app  = cmd
  const desc = chalk.gray(`
    Options with commander are defined with the .option() method, also serving as
    documentation for the options. The example below parses args and options from
    process.argv, leaving remaining args as the program.args array which were not
    consumed by options.`)

  app.version(c(pkg.version))
  app.description(desc)
  app.usage('[options]')
  app.option(g('-p, --package    [name]'),  chalk.gray(': installs the package types declared in `config.cson`. '), require('./package'))
  app.option(y('-e, --editors    [name]'),  chalk.gray(': setup text editors, IDE, terminal and all that jazz.  '), require('./editor'))
  app.option(b('-g, --gitconfig  [name]'),  chalk.gray(': setup global git config and provider SSH and GPG keys.'), require('./gitconfig'))
  app.option(r('-t, --toolbox    [name]'),  chalk.gray(': configs for: Nginx, PHP-fpm, MongoDB, MySQL and Redis.'), require('./toolbox'))
  app.parse(process.argv)

  return app
}
