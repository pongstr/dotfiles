'use strict'

const fs = require('fs')
const sh = require('shelljs')
const path = require('path')
const chalk = require('chalk')
const cson = require('cson')
const config = cson.parseFile(path.join(__dirname, '/../config.cson'))

module.exports = (type) => {
  const init = {
    fonts: null,
    casks: null,
    brew : null,
    npm  : null,
    gem  : null,
    all  : null
  }

  init.brew = () => {
    (config.brew && config.brew.packages.length > 0) &&
      config.brew.packages.forEach((pkg, idx, arr) => {
        console.info('\n', chalk.green(`  --> Installing App: ${pkg}`), '\n')
        exec(`brew install ${pkg}`)
      })

    exec('brew cleanup')
  }

  init.cask = () => {
    (config.cask && config.cask.length > 0) &&
      config.cask.forEach((cask, idx, arr) => {
        console.info('\n', chalk.green(`  --> Installing App: ${cask}`), '\n')
        exec(`brew cask install ${cask}`)
      })

    exec('brew cask cleanup')
  }

  init.font = () => {
    (config.fonts && config.fonts.length > 0) &&
      config.fonts.forEach((font, idx, arr) => {
        console.info('\n', chalk.green(`  --> Installing Font: ${font}`), '\n')
        exec(`brew cask install ${font}`, { silent: true })
      })
  }

  init.gem = () => {
    if (config.gem && config.gem.length > 0) {
      console.info(chalk.yellow(' --> Updating Ruby Gem'))
      exec('gem update --system')
      config.gem.forEach((gem, idx, arr) => {
        console.info('\n', chalk.green(`  --> Installing Gem: ${gem}`), '\n')
        exec(`gem install ${gem}`)
      })
    }
  }

  init.npm = () => {
    if (config.npm && config.npm.length > 0) {
      console.info(chalk.yellow('  --> Updating Npm to latest version.'), '\n')
      exec('npm install -g npm && npm -v')
      config.npm.forEach((npm, idx, arr) => {
        console.info('\n', chalk.green(`  --> Installing Node Package: ${npm}`), '\n')
        exec(`npm install -g ${npm}`)
      })
    }
  }

  init.all = () => {
    init.cask()
    init.font()
    init.gem()
    init.npm()
    return
  }

  return init[type] && init[type]()
}
