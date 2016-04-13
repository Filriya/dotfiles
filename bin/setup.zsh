#!/bin/zsh
cd $(dirname $0)
git submodule update --init --recursive

#prezto関連設定
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/dotfiles/.zprezto/runcoms/^(README.md|zshrc|zpreztorc)(.N); do
  ln -Fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

#dotfile関連設定
for dotfile in ../?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -fs "$PWD/$dotfile" $HOME
  fi
done

if [ ! -e $HOME/.gitconfig.local ]; then
  echo "Create .gitconfig.local"
  echo -n "Name? >"
  read name
  echo -n "Email? >"
  read email
  m4 -D__NAME__=$name -D__EMAIL__=$email gitconfig.local.m4 > $HOME/.gitconfig.local
fi

#vim関連設定

#neobundleとvimprocだけは先にcloneしておく
git clone git://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
git clone git://github.com/Shougo/vimproc.vim ~/.vim/bundle/vimproc

#vimprocのmake
cd ~/.vim/bundle/vimproc
echo "vimproc setup"
if [ `uname` = "Darwin" ]; then
  make -f make_mac.mak
elif [ `uname` = "Linux" ]; then
  make -f make_unix.mak
fi

#vimのpluginをインストール
vim +NeoBundleInstall +q
