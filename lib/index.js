const cmd      = require('commander')
const packges  = require('./package')
const gitsetup = require('./gitconfig')

module.exports = (pkg, config) => {
  const app = cmd
  const cfg = Object.assign({ desc: '' }, pkg, {config})

  app.version(cfg.version)
  app.description(cfg.desc)

  app
    .command('install <manager> [pkg]')
    .description('Install a package using brew, cask, fonts, gem or npm')
    .option('-r, --root', 'Executed installation as a sudo user (use with caution).')
    .option('-s, --save', 'Saves the installed package to the config file.')
    .action(packges(config, 'install'))

  app
    .command('gitconf <action>')
    .description('Setup and/or install git configuration, ssh and gpg keys')
    .option('-c, --config [entry]', '')
    .action(gitsetup)

  app.parse(process.argv)
  return app
}
