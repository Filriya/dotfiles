#!/bin/zsh
cd $(dirname $0)
git submodule update --init --recursive

#prezto関連設定
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/dotfiles/.zprezto/runcoms/^(README.md|zshrc|zpreztorc)(.N); do
  ln -Fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

#dotfile関連設定
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
  then
    ln -Fs "$PWD/$dotfile" $HOME
  fi
done

#vim関連設定

#neobundleとvimprocだけは先にcloneしておく
git clone git://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
git clone git://github.com/Shougo/vimproc.vim ~/.vim/bundle/vimproc

#vimprocのmake
cd ~/.vim/bundle/vimproc
echo "vimproc setup"
if [ `uname` = "Darwin" ]; then
  echo -n "Make make_mac?[y/n] "
  read flag
  if [ ${flag} = 'y' ]; then
    make -f make_mac.mak
  fi
elif [ `uname` = "Linux" ]; then
  echo -n "Make make_unix.mak?[y/n] "
  read flag
  if [ ${flag} = 'y' ]; then
    make -f make_unix.mak
  fi
fi

#vimのpluginをインストール
vim +NeoBundleInstall +q