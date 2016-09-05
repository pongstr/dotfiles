'use strict'

chlk  = require 'chalk'
prmpt = require 'prompt'

require 'shelljs/global'

module.exports =
  git_config: () ->
    prmpt.start()
    prmpt.get [
      {
        name: 'username'
        required: true
      }
      {
        name: 'email'
        required: true
      }
    ], (err, res) ->
      if res and res.username and res.email
        exec "git config --global user.name #{res.username}; git config --global #{res.email}"
        exec "git config --global push.default simple; git config --global alias.lg \"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative\""
        console.info chlk.green "
        \n    Contributor  Name: #{res.username}
        \n    Contributor Email: #{res.email}\n"
    return

  bitbucket: () ->
    prmpt.start()
    prmpt.get [
      { name: 'bitbucket_label',      require: false }
      { name: 'bitbucket_passphrase', require: false, hidden: true }
      { name: 'bitbucket_username',   require: false }
      { name: 'bitbucket_password',   require: false, hidden: true }
    ], (err, res) ->
      if res
        console.info chlk.green "Generating SSH Key for your Bitbucket account, please wait..."

        exec "rm -rf ~/.ssh/bitbucket_rsa ~/.ssh/bitbucket_rsa.pub", silent: true
        exec "ssh-keygen -q -f ~/.ssh/bitbucket_rsa -P #{res.bitbucket_passphrase}; ssh-add $HOME/.ssh/bitbucket_rsa"

        payload = JSON.stringify(
          label: res.bitbucket_label
          key: exec "cat ~/.ssh/bitbucket_rsa.pub", silent: true
        ).replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0')

        console.info chlk.blue "
        \n    --> Okay, since you've entered your Bitbucket credentials,
        \n        I will now use the authorization to add these SSH Keys to your account.
        \n        Hang tight! this won't be long.
        \n"

        exec "curl --user #{res.bitbucket_username}:#{res.bitbucket_password} -X POST --data \"#{payload}\" \"https://bitbucket.org/api/1.0/users/#{res.bitbucket_username}/ssh-keys/\" -H \"Content-Type: application/json\" -#o /dev/null"
        exec "ssh -T git@bitbucket.org"

        console.info chlk.green "
        \n    --> SSH Key has been successfully added!
        \n    --> Accessing Bitbucket to verify the SSH Keys\n"
        exec "ssh -T git@bitbucket.org"
    return

  github: () ->
    prmpt.start()
    prmpt.get [
      { name: 'github_email',       required: true }
      { name: 'github_username',    required: true }
      { name: 'github_password',    required: true, hidden: true }
      { name: 'github_title',       required: true }
      { name: 'github_passphrase',  required: true, hidden: true }
    ], (err, res) ->
      if res
        console.info chlk.green "Generating SSH Key for your Github account, please wait..."

        exec "rm -rf ~/.ssh/github_rsa ~/.ssh/github_rsa.pub", silent: true
        exec "ssh-keygen -t rsa -C \"#{res.github_email}\" -f \"$HOME/.ssh/github_rsa\" -P \"#{res.github_passphrase}\" -q; ssh-add $HOME/.ssh/github_rsa"

        payload = JSON.stringify(
          title: res.github_title
          key: exec "cat $HOME/.ssh/github_rsa.pub", silent: true
        ).replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0')

        exec "curl --user #{res.github_username}:#{res.github_password} -X POST --data \"#{payload}\" https://api.github.com/user/keys -#o /dev/null"
        console.info chlk.green "
          \n    --> SSH Key has been successfully added!
          \n    --> Accessing Github to verify the SSH Keys\n"

        exec "ssh -T git@github.com"
    return

  gitlab: () ->
    console.log "Coming Soon..."
    return
