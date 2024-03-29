#!/bin/bash

printf "\e[0;32m
Setting up Github SSH Key
=========================
\e[0m

\e[0;33mA Github personal access token is required to do fully automate
SSH Key generation and adding it to your Github account.\e[0m

\e[0;37mYou may generate a personal access token by this heading to this
URL: https://github.com/settings/tokens and clicking on the
Generate new token button.\e[0m

Would you like to generate new token?

- [1]: Yes (this will open Github dashboard).
- [2]: No, I will manually add it to Github.
- [3]: No, I already have one.

"

read -p "Select an option please: " GITHUB_GENERATE_TOKEN
echo ""

while true; do
  case $GITHUB_GENERATE_TOKEN in
    1)
      open "https://github.com/settings/tokens"
      read -p "Personal Access Token: " GITHUB_PERSONAL_TOKEN
      echo ""
      break;;
    2)
      GITHUB_PERSONAL_TOKEN=""
      printf "\e[1;33m⚠️  SSH key will be created but you will have to manually add it to\n   your Github dashboard.\n\e[0m"
      echo ""
      break;;
    3)
      read -p "Personal Access Token: " GITHUB_PERSONAL_TOKEN
      echo ""
      break;;
  esac
done

HOME_PATH=$HOME
GITHUB_RSA="$HOME_PATH/.ssh/github_rsa"

writeconfig() {
cat >> $HOME_PATH/.ssh/config << EOF
Host github.com
  Hostname github.com
  IdentityFile $HOME/.ssh/github_rsa
  UseKeychain yes

Host *.github.com
  Hostname *.github.com
  IdentityFile $HOME/.ssh/github_rsa
  UseKeychain yes

Host *
  UseKeychain yes
EOF
}

if [ ! -z "$GITHUB_PERSONAL_TOKEN" ]; then
  echo "export GITHUB_PERSONAL_TOKEN=$GITHUB_PERSONAL_TOKEN" >> $HOME_PATH/.bashrc
  echo "export GITHUB_PERSONAL_TOKEN=$GITHUB_PERSONAL_TOKEN" >> $HOME_PATH/.zshrc
  source $HOME_PATH/.bashrc && source $HOME_PATH/.zshrc
fi

if [ -d "$HOME_PATH/.ssh" ]; then
  if [ -e "$HOME_PATH/.ssh/config" ]; then
    touch $HOME_PATH/.ssh/config
    writeconfig
  fi;
else
  mkdir -p $HOME_PATH/.ssh && touch $HOME_PATH/.ssh/config
  writeconfig
fi

read -p "Github Email Address: " GITHUB_EMAIL
read -p "Github Username: " GITHUB_USERNAME
read -s -p "SSH Passphrase: "  GITHUB_SSH_PASSPHRASE

rm -rf $GITHUB_RSA $GITHUB_RSA.pub
sleep 1
ssh-keygen -t rsa -C $GITHUB_EMAIL -f $GITHUB_RSA -P $GITHUB_SSH_PASSPHRASE -q
sleep 1
eval $(ssh-agent -s) && ssh-add $GITHUB_RSA


if [ -z "$GITHUB_PERSONAL_TOKEN" ]; then
  echo "
  All done! Copy+Paste it to your github dashboard.
  ------------------------------------------------
  "
  sleep 1
  open https://github.com/settings/keys
  cat $GITHUB_RSA.pub
  echo "
  ------------------------------------------------
  "
else
  TITLE=$(hostname -s)
  curl -H "Authorization: token ${GITHUB_PERSONAL_TOKEN}" \
    -H "Content-Type: application/json" \
    -X POST --data "{ \"title\": \"$TITLE\", \"key\": \"`cat $GITHUB_RSA.pub`\" }" \
    https://api.github.com/user/keys -#o /dev/null

  echo ""
  ssh -T git@github.com
  sleep 1
  open https://github.com/settings/keys
fi

exit 0
