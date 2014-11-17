#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# linuxとosx、個別にロードしたい設定
if [ `uname` = "Darwin" ]; then
  #mac用のコード
  if [ -f ~/dotfiles/osx.zsh ]; then
    source ~/dotfiles/osx.zsh
  fi
elif [ `uname` = "Linux" ]; then
  #Linux用のコード
  if [ -f ~/dotfiles/linux.zsh ]; then
    source ~/dotfiles/linux.zsh
  fi
fi

eval $(dircolors ${HOME}/.dircolors )

#alias myssh="ssh $@ && echo $@";
