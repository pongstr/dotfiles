'use strict'

const fs    = require('fs')
const sh    = require('shelljs')
const join  = require('path').join
const chalk = require('chalk')
const cson  = require('cson')
const conf  = cson.parseFile(join(__dirname, '../config.cson'))

function createConfig (ctx) {
  // Homebrew Path
  const BREW = sh.env.brew = '/usr/local/etc'
  // Path where config file is stored
  const PATH = join(__dirname, '../config')
  // Configuration context
  const CONTEXT = ctx.template(ctx.conf.context)
  // Meta Props
  const META = ctx.conf.meta
  // Toolname
  const NAME = ctx.name
  // Config File
  const FILE = META.file
  // Symlink Target
  const SYMLINK = META.path ? join(BREW, NAME, FILE) : join(BREW, FILE)

  // Create directory where config will be stored
  ;(!sh.test('-d', join(PATH, NAME))) &&
    sh.mkdir('-p', join(PATH, NAME))

  // Create directories
  ;(META.dirs && META.dirs.length > 0) &&
    META.dirs.forEach((dir, idx, arr) => {
      console.info(
        chalk.gray('Sub-directory created:'),
        chalk.green(join(PATH, NAME, dir))
      )

      ;(!sh.test('-d', join(PATH, NAME, dir))) &&
        sh.mkdir('-p', join(PATH, NAME, dir))
    })

  // Write config file to directory
  fs.writeFile(`${PATH}/${NAME}/${FILE}`, CONTEXT, 'utf8', (err) => {
    if (err) console.error(err)
    // Symlink the config file
    console.info(
      '\n',
      chalk.gray('Created Symlink:'),
      chalk.yellow(`${PATH}/${NAME}/${META.file}`),
      chalk.gray('to'),
      chalk.green(SYMLINK),
      '\n'
    )
    sh.ln('-sf', `${PATH}/${NAME}/${META.file}`, SYMLINK)
  })
}

module.exports = (tool) => {
  const template = {
    dnsmasq : require('./templates/dnsmasq'),
    mongodb : require('./templates/mongodb'),
    nginx   : require('./templates/nginx'),
    redis   : require('./templates/redis')
  }

  return createConfig({
    name     : tool,
    conf     : conf[tool],
    template : template[tool]
  })
}
o9l