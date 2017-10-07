const sh   = require('shelljs')
const fs   = require('fs')
const path = require('path')
const chlk = require('chalk')

/**
 * @module PackageInstaller
 * @constant installPackage
 * @description
 * @param   {Object} config
 * @param   {String} action
 * @returns {code, stdout, stderr}
 */
const install = (config, action) => function install (mgr, pkg, opts) {
  // Ensure package manager executables are installed
  if (!Object.prototype.hasOwnProperty.call(config, mgr)) {
    console.error(chlk.bgRed(`\n\t Package Manager: ${mgr} is not registered and does not have a config file. \n`))
    process.exit(1)
  }

  /* Installer Function */
  function installPackage () {
    const packages = config[mgr].packages
    const cmd = mgr === 'cask' ? 'brew cask' : mgr

    if (!opts.root) {
      return (!pkg)
        ? packages.forEach(item => sh.exec(`${cmd} ${action} ${item}`))
        : sh.exec(`${cmd} ${action} ${pkg}`)
    }

    if (opts.root && (mgr === 'gem')) {
      return (!pkg)
        ? packages.forEach(item => sh.exec(`sudo ${cmd} ${action} ${item}`))
        : sh.exec(`sudo ${cmd} ${action} ${pkg}`)
    }
  }

  /* Save Package Function */
  function savePackage () {
    const file = path.join(__dirname, '..', `.${mgr}`)
    const text = `  - "${pkg}"\n`
    return (config[mgr].packages.indexOf(pkg) === -1)
      ? fs.appendFileSync(file, text, 'utf8') && true
      : false
  }

  // Save package to config file
  opts.save && savePackage()

  // exec Install package(s)
  return installPackage()
}

const defaults = (config, action) => function installdefaults () {
  function installPackages (pkg) {
    return config[pkg].packages.forEach((item) => {
      const cmd = pkg === 'cask' ? 'brew cask ' : pkg
      ;sh.exec(`${cmd} install ${item}`)
    })
  }

  return Object.keys(config).filter((i) => i !== 'root')
    .forEach(pkg => installPackages(pkg))
}

exports.install  = install
exports.defaults = defaults
