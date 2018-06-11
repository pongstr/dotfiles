const sh   = require('shelljs')
const chlk = require('chalk')

const _exec = process.env.DEBUG ? console.info : sh.exec

const term = (options) => {
  console.info(chlk.green('\nSetting up Terminal theme.'))
  _exec('touch $HOME/.hushlogin && open -a Terminal $(pwd)/lib/shared/themes/Pongstr\\ Base-16.terminal\n')

  console.info(chlk.green('Setting up zshell theme.'))
  _exec('ln -sf $(pwd)/lib/shared/themes/Pongstr\\ Base-16.zsh-theme $HOME/.oh-my-zsh/themes/pongstr.zsh-theme\n')

  console.info(chlk.green('Reload Terminal session.'))
  _exec('cp $(pwd)/lib/shared/.zshrc $HOME/.zshrc && source $HOME/.zshrc\n')

  return true
}

const vim = (options) => {
  console.info(chlk.green('\nCreating Vim directories.'))
  _exec('mkdir -p $HOME/.vim && mkdir -p $HOME/.vim/{backups,colors,plugins,swaps,undo}')

  console.info(chlk.green('Installing `.vimrc`.'))
  _exec('ln -sf $(pwd)/lib/shared/.vim-config $HOME/.vimrc')

  console.info(chlk.green('Installing Vim colors.'))
  _exec('ln -sf $(pwd)/lib/shared/.vim-config $HOME/.vim/colors/pongstr.vim')

  console.info(chlk.green('Done, restart the Terminal for changes to take effect.\n'))

  return true
}

const vscode = (options) => {
  console.info(chlk.green('Copying VSCode Settings.'));
  _exec('cp $(pwd)/lib/shared/.vscode-settings $HOME/Library/Application\\ Support/Code/User/settings.json\n');

  console.info(chlk.green('Copying VSCode Extensions.'));
  _exec('cp $(pwd)/lib/shared/.vscode-extensions $HOME/Library/Application\\ Support/Code/User/extensions.json');

  console.info(chlk.green('Copying VSCode Keybindings.'));
  _exec('cp $(pwd)/lib/shared/.vscode-keybindings $HOME/Library/Application\\ Support/Code/User/keybindings.json');

  return true
}

module.exports = config => function install (editor, options) {
  const editors = { term, vim, vscode }

  editors.all = (opts) => term(opts) && vim(opts) && vscode(opts)

  return editors[editor]
    ? editors[editor](options)
    : editors.all(options)
}
