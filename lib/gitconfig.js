'use strict'

const configTemplate = `"
Host bitbucket.org
  Hostname bitbucket.org
  IdentityFile $HOME/.ssh/bitbucket_rsa

Host github.com
  Hostname github.com
  IdentityFile $HOME/.ssh/github_rsa

Host *.github.com
  Hostname *.github.com
  IdentityFile $HOME/.ssh/github_rsa

Host gitlab.com
  Hostname gitlab.com
  IdentityFile $HOME/.ssh/gitlab_rsa

Host *
    UseKeychain yes
"`

const sh = require('shelljs')
const chalk = require('chalk')
const prompt = require('prompt')

module.exports = (conf) => {
  const HOME = sh.env.HOME
  const init = { config: null, setup: null }

  // Create SSH Directory if it doesn't exist
  ;(!sh.test('-d', `${HOME}/.ssh`)) &&
    sh.mkdir('-p', `${HOME}/.ssh`)

  // Create config file entry for each SSH Key
  ;(!sh.test('-f', `${HOME}/.ssh/config`)) &&
    sh.touch(`${HOME}/.ssh/config`) &&
    sh.exec(`echo ${configTemplate} > ${HOME}/.ssh/config`)

  init.config = () => {
    prompt.start()
    prompt.get([
      { name: 'user', required: true },
      { name: 'email', required: true }
    ], (err, res) => {
      if (!err && res) {
        sh.exec(`git config --global user.name ${res.user}`)
        sh.exec(`git config --global user.email ${res.email}`)
        sh.exec(`git config --global push.default simple; git config --global alias.lg \"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative\"`)
        console.info(
          '\n',
          chalk.gray(' Contributor Name:'), chalk.yellow(res.user), '\n',
          chalk.gray('Contributor Email:'), chalk.yellow(res.email)
        )
      }
    })
  }

  init.bitbucket = () => {
    prompt.start()
    prompt.get([
      { name: 'bitbucket_label',      require: false },
      { name: 'bitbucket_passphrase', require: false, hidden: true },
      { name: 'bitbucket_username',   require: false },
      { name: 'bitbucket_password',   require: false, hidden: true },
    ], (err, res) => {
      const bitbucket = `${HOME}/.ssh/bitbucket_rsa`
      let payload = ''

      if (!err && res) {
        console.info(
          '\n',
          chalk.gray('Generating SSH Key for your Bitbucket account,\n'),
          chalk.gray('Please sit back and relax while we work this out.\n')
        )

        console.info(chalk.gray('Clean up existing bitbucket ssh keys.'))
        sh.exec(`rm -rf ${bitbucket} ${bitbucket}.pub`, { silent: true })

        sh.exec(`ssh-keygen -q -f ${bitbucket} -P ${res.bitbucket_passphrase}`)
        sh.exec(`eval \$(ssh-agent -s) && ssh-add ${bitbucket} -p ${res.bitbucket_passphrase}`, { silent: true })

        payload = JSON.stringify({
          label: res.bitbucket_label,
          key: sh.exec(`cat ${bitbucket}.pub`, { silent: true})
        }).replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0')

        sh.exec(`curl --user ${res.bitbucket_username}:${res.bitbucket_password} -X POST --data \"${payload}\" \"https://bitbucket.org/api/1.0/users/${res.bitbucket_username}/ssh-keys/\" -H \"Content-Type: application/json\" -#o /dev/null`)
        sh.exec('ssh -T git@bitbucket.org')
      }
    })
  }

  init.github = () => {
    prompt.start()
    prompt.get([
      { name: 'github_email',       required: true },
      { name: 'github_username',    required: true },
      { name: 'github_password',    required: true, hidden: true },
      { name: 'github_title',       required: true },
      { name: 'github_passphrase',  required: true, hidden: true }
    ], (err, res) => {
      const github = `${HOME}/.ssh/github_rsa`
      let payload = ''

      if (!err && res) {
        console.info(
          '\n',
          chalk.gray('Generating SSH Key for your Github account,\n'),
          chalk.gray('Please sit back and relax while we work this out.\n')
        )

        console.info(chalk.gray('Clean up existing github ssh keys.'))
        sh.exec(`rm -rf ${github} ${github}.pub`, { silent: true })
        sh.exec(`ssh-keygen -t rsa -C "${res.github_email}" -f "${github}" -P "${res.github_passphrase}" -q`, { silent: true })
        sh.exec(`eval \$(ssh-agent -s) && ssh-add ${github}`, { silent: true })

        payload = JSON.stringify({
          title: res.github_title,
          key: sh.exec(`cat ${github}.pub`, { silent: true})
        }).replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0')

        sh.exec(`curl --user ${res.github_username}:${res.github_password} -X POST --data "${payload}" https://api.github.com/user/keys -#o /dev/null`, { silent: true })
        sh.exec('ssh -T git@github.com')
      }
    })
  }

  init.gitlab = () => {
    console.info(
      '\n',
      chalk.gray('Please see Gitlab Issue #3472:'),
      '\n',
      chalk.yellow('https://gitlab.com/gitlab-org/gitlab-ce/issues/3472#note_22375565'),
      '\n'
    )
    return
  }

  return init[conf] ? init[conf]() : init.default()
}
