const configTemplate = `"
Host bitbucket.org
  Hostname bitbucket.org
  IdentityFile $HOME/.ssh/bitbucket_rsa

Host github.com
  Hostname github.com
  IdentityFile $HOME/.ssh/github_rsa
  UseKeychain yes

Host *.github.com
  Hostname *.github.com
  IdentityFile $HOME/.ssh/github_rsa
  UseKeychain yes

Host gitlab.com
  Hostname gitlab.com
  IdentityFile $HOME/.ssh/gitlab_rsa

Host *
    UseKeychain yes
"`
