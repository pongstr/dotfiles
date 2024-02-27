#!/bin/bash

read -p "Your Git username: " GIT_USERNAME
read -p "   Your Git email: " GIT_EMAIL

git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL
git config --global credential.helper osxkeychain
git config --global commit.gpgsign true
git config --global push.default simple
git config --global init.defaultbranch main
git config --global pull.rebase true
git config --global pull.ff only
git config --global alias.clean "clean -f -d"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

printf "
      Git is now configured with the following settings:
      \e[0;1m
      user.name: $GIT_USERNAME
      user.email: $GIT_EMAIL
      credential.helper: osxkeychain
      commit.gpgsign: true
      push.default: simple
      init.defaultbranch: main
      pull.rebase: true
      pull.ff: only
      alias.clean: clean -f -d
      alias.lg: log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
      \e[0m\n\n"

sh ./utils/setup.sh
