const sh   = require('shelljs')
const fs   = require('fs')
const chlk = require('chalk')
const { resolve } = require('path')

const _exec = process.env.DEBUG ? console.info : sh.exec

const review = pkg => fs.readFileSync(resolve(__dirname, '..', `.${pkg}`), 'utf8')

const brew = (config, _package, option) => {
  const taps = config.taps
  const pkgs = config.packages
  const file = resolve(__dirname, '..', '.brew')

  if (option.review) {
    let message  = chlk.blue('\n\nHomebrew: ')
    message += chlk.blue('Packages and taps that will be installed.\n\n')
    return console.info(message, review('brew'))
  }

  console.info(chlk.blue('Updating Homebrew...'))
  _exec('brew update && brew upgrade')

  if (_package) {
    _exec(`brew install ${_package}`)
    option.save && fs.appendFileSync(file, `  - "${_package}"\n`, 'utf8')
    return true
  }

  taps.forEach((pkg) => {
    console.info(chlk.green(`Installing brew tap ${pkg}`))
    _exec(`brew tap ${pkg}\n`)
  })

  pkgs.forEach((pkg) => {
    console.info(chlk.green(`Installing brew ${pkg}`))
    _exec(`brew install ${pkg}\n`)
  })

  console.info(chlk.yellow('Cleaning up...'))
  _exec('brew cleanup\n')
  return true
}

const cask = (config, _package, option) => {
  const pkgs = config.packages
  const file = resolve(__dirname, '..', '.cask')

  if (option.review) {
    let message  = chlk.blue('\n\nBrew Cask: ')
    message += chlk.blue('Native Applications that will be installed.\n\n')
    return console.info(message, review('cask'))
  }
  if (_package) {
    _exec(`brew cask install ${_package}`)
    option.save && fs.appendFileSync(file, `  - "${_package}"\n`, 'utf8')
    return true
  }

  pkgs.forEach((pkg) => {
    console.info(chlk.green(`Brew Cask: ${pkg}`))
    _exec(`brew cask install ${pkg}\n`)
  })

  console.info(chlk.yellow('Cleaning up...'))
  _exec('brew cask cleanup\n')

  return true
}

const gem = (config, _package, option) => {
  const pkgs = config.packages
  const file = resolve(__dirname, '..', '.gem')

  if (option.review) {
    let message  = chlk.blue('\n\nRuby Gems: ')
    message += chlk.blue('gems that will be installed.\n\n')
    return console.info(message, review('gem'))
  }

  console.info(chlk.blue('Updating Gem...'))
  _exec('gem update system\n')

  if (_package) {
    _exec(`gem install ${_package}`)
    option.save && fs.appendFileSync(file, `  - "${_package}"\n`, 'utf8')
    return true
  }

  pkgs.forEach((pkg) => {
    console.info(chlk.green(`Installing Gem: ${pkg}`))
    _exec(`gem install ${pkg}\n`)
  })

  return true
}

const npm = (config, _package, option) => {
  const pkgs = config.packages
  const file = resolve(__dirname, '..', '.npm')

  if (option.review) {
    let message  = chlk.blue('\n\nNPM: ')
    message += chlk.blue('node modules that will be installed.\n\n')
    return console.info(message, review('npm'))
  }

  console.info(chlk.blue('Updating NPM...'))
  _exec('npm i -g npm\n')

  if (_package) {
    _exec(`npm install -g ${_package}`)
    option.save && fs.appendFileSync(file, `  - "${_package}"\n`, 'utf8')
    return true
  }

  pkgs.forEach((pkg, idx) => {
    (idx === 0)
      ? console.info(chlk.green(`Updating NPM: ${pkg}`))
      : console.info(chlk.green(`Installing NPM: ${pkg}`))
    _exec(`npm install -g ${pkg}\n`)
  })

  return true
}

module.exports = config => function install (manager, pkg, options) {
  const installer = { brew, cask, gem, npm }
  const all = () => Object.keys(installer).forEach(item =>
    installer[item](config[item], pkg, options))

  return installer[manager]
    ? installer[manager](config[manager], pkg, options)
    : all()
}
