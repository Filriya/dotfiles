#!/bin/bash
cd `dirname $0` # scriptの位置に移動
if [ "$(uname)" == 'Darwin' ]; then
  ./darwin/brew.sh
  ./darwin/link.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  ./linux/brew.sh
fi
