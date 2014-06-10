#!/bin/sh
#cd $(dirname $0)
#for dotfile in .?*
#do
#    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
#    then
#        ln -Fis "$PWD/$dotfile" $HOME
#    fi
#done

git clone git://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
vim +NeoBundleInstall +q

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
