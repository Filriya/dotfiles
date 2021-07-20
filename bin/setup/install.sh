#!/bin/bash
cd `dirname $0` # scriptの位置に移動

if [ "$(uname)" == 'Darwin' ]; then

  if ! type "brew" > /dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  ./brew/darwin.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if ! type "brew" > /dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

    # 環境変数の設定
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
  fi
  ./brew/linux.sh
fi
