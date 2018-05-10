const sh   = require('shelljs')
const chlk = require('chalk')

const _exec = process.env.DEBUG ? console.info : sh.exec

const term = (options) => {
  console.info(chlk.green('\nSetting up Terminal theme.'))
  _exec('touch $HOME/.hushlogin && open -a Terminal $(pwd)/lib/shared/themes/Pongstr Base-16.terminal\n')

  console.info(chlk.green('Setting up zshell theme.'))
  _exec('ln -sf $(pwd)/lib/shared/themes/Pongstr Base-16.zsh-theme $HOME/.oh-my-zsh/themes/pongstr.zsh-theme\n')

  console.info(chlk.green('Reload Terminal session.'))
  _exec('cp $(pwd)/shared/.zshrc $HOME/.zshrc && source $HOME/.zshrc\n')
}

const vim = (options) => {
  console.info(chlk.green('\nCreating Vim directories.'))
  _exec('mkdir -p $HOME/.vim && mkdir -p $HOME/.vim/{backups,colors,plugins,swaps,undo}')

  console.info(chlk.green('Installing `.vimrc`.'))
  _exec('ln -sf $(pwd)/lib/shared/.vim-config $HOME/.vimrc')

  console.info(chlk.green('Installing Vim colors.'))
  _exec('ln -sf $(pwd)/lib/shared/.vim-config $HOME/.vim/colors/pongstr.vim')

  console.info(chlk.green('Done, restart the Terminal for changes to take effect.\n'))
}

const vscode = (options) => {

}

module.exports = config => function install (editor, options) {
  const editors = { term, vim, vscode }
  // return editors[editor] ? editors[editor](pkg, options)
  //   : all()
  return editors[editor] && editors[editor](options)
}
