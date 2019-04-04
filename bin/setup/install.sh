#!/bin/bash
cd `dirname $0` # scriptの位置に移動

if [ "$(uname)" == 'Darwin' ]; then

  if ! type "brew" > /dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  ./brew/brew.sh
  ./brew/brew.darwin.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if ! type "brew" > /dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi
  ./brew/brew.sh
  ./brew/brew.linux.sh
fi
