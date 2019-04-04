#/bin/bash
# Make sure using latest Homebrew
brew update
brew upgrade

# Packages
brew install autoconf
brew install automake
brew install ansible
brew install bash-completion
brew install lua
brew install luajit
brew install git
brew install gibo
brew install mercurial
brew install pcre
brew install python

brew install zsh
# zsh を etc/shells に追加
if ! `grep "$(brew --prefix)/bin/zsh" /etc/shells > /dev/null` ; then
  echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
fi

brew install exa
brew install peco
brew install z
brew install ghq hub
brew install screen
brew install the_silver_searcher

brew install ripgrep

# nvim
brew install vim
brew install nvim
pip3 install nvim


brew cleanup

