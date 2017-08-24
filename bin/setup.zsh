#!/bin/zsh
cd $(dirname $0)
git submodule update --init --recursive

#prezto関連設定
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/dotfiles/.zprezto/runcoms/^(README.md|zshrc|zpreztorc)(.N); do
  ln -Fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

#dotfile関連設定
cd ../
for dotfile in .*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    echo $dotfile
    ln -fs "$PWD/$dotfile" $HOME
  fi
done

if [ ! -e $HOME/.gitconfig.local ]; then
  echo "Create .gitconfig.local"
  echo -n "Name? >"
  read name
  echo -n "Email? >"
  read email
  m4 -D__NAME__=$name -D__EMAIL__=$email $HOME/dotfiles/gitconfig.local.m4 > $HOME/.gitconfig.local
fi

