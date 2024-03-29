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

echo ""

sh $(pwd)/utils/setup_github.sh
