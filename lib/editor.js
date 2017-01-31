'use strict'

'use strict'

const fs = require('fs')
const sh = require('shelljs')
const path = require('path')
const chalk = require('chalk')
const cson = require('cson')
const config = cson.parseFile(path.join(__dirname, '/../config.cson'))

module.exports = (editor) => {
  const HOME = sh.env.HOME
  const init = {
    atom: null,
    term: null,
    subl: null,
    vim : null
  }

  init.atom = () => {
    const home = `${HOME}/.atom`
    const atom = config.editor.atom
    // Create Atom Config Directory
    ;(sh.test('-d', home)) && sh.mkdir('-p', home)

    // Install Atom Plugins
    ;(atom && atom.plugins.length > 0)
      ? atom.plugins.forEach((plugin, idx, arr) => {
          console.info(chlk.green(` --> Installing plugin ${plugin}...`))
          exec(`apm install ${plugin}`)
        })
      : console.info(
        chlk.gray(' --> No plugins declared, skipping this process.'))

    // Install Atom Configs and Stylesheets
    ;(atom && atom.config.length > 0)
      ? atom.config.forEach((config, idx, arr) => {
          console.info(chalk.green('  --> Installing Atom Configs...'))
          sh.cp('-f', `${home}${config.source}`, `${home}${config.target}`)
        })
      : console.info(
        chlk.gray(' --> No configs declared, skipping this process.'))
  }

  init.term = () => {
    const home = HOME
    const lib  = path.join(__dirname, './shared')
    const term = config.editor.term

    ;(term.config && term.config.length > 0) &&
      term.config.forEach((config, idx, arr) => {
        console.info(chalk.green(`  --> Installing run commands ${config.source}`))
        sh.cp('-f', `${lib}/${config.source}`, config.target)
      })

    console.info(chalk.green('  --> Installing oh-my-zsh, please wait...'))
    exec('sh -c "\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"')
  }

  init.subl = () => {
    const home = HOME
    const subl = config.editor.subl
    return
  }

  init.vim = () => {
    const home = `${HOME}/.vim`
    const lib  = path.join(__dirname, './shared')
    const vim  = config.editor.vim
    const dir  = [
      'backups',
      'colors',
      'plugins',
      'swaps',
      'undo'
    ]

    ;(dir && dir.length > 0) && dir.forEach((folder, idx, arr) => {
      // Create Vim folders to centralize shits
      if (sh.test('-d', `${home}/${folder}`)) {
        console.info(chalk.green(`  --> Creating Vim folder: ${folder}\n`))
        sh.mkdir('-p', `${home}/${folder}`)
      }
    })

    // Install Vim Plugins
    if (vim.plugins && vim.plugins.length > 0) {
      vim.plugins.forEach((plugin, idx, arr) => {
        console.info(chalk.green(`  --> Installing Vim plugin: ${plugin}\n`))
        // @TODO: Add appropriate install command here
      })
    }

    // Install Vim Configs
    ;(vim.config && vim.config.length > 0) &&
      vim.config.forEach((config, idx, arr) => {
        console.info(chalk.green(`  --> Installing Vim config ${config.target}\n`))
        sh.cp('-f', `${lib}/${config.source}`, config.target)
      })
  }

  function install () {
    init.atom()
    init.term()
    init.subl()
    init.vim()
  }

  return init[editor] ? init[editor]() : install()
}
