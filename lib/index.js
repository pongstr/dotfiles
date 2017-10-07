const cmd      = require('commander')
const gitsetup = require('./gitconfig')
const { install, defaults } = require('./package')

module.exports = (pkg, config) => {
  const app = cmd
  const cfg = Object.assign({ desc: '' }, pkg, {config})

  app.version(cfg.version)
  app.description(cfg.desc)

  app
    .command('init')
    .description('Installs default packages declared in the config dotfiles.')
    .action(defaults(config, 'install'))

  app
    .command('install <manager> [pkg]')
    .description('Install a package using brew, cask, fonts, gem or npm')
    .option('-r, --root', 'Execute an installation as a sudo user (use with caution).')
    .option('-s, --save', 'Saves the installed package to the config file.')
    .action(install(config, 'install'))

  app
    .command('gitconf <action>')
    .description('Setup and/or install git configuration, ssh and gpg keys')
    .option('-c, --config [entry]', '')
    .action(gitsetup)

  app.parse(process.argv)
  return app
}
