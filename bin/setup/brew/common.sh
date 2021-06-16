#/bin/bash
# Make sure using latest Homebrew
brew update
brew upgrade

brew install zsh
# zsh を etc/shells に追加
if ! `grep "$(brew --prefix)/bin/zsh" /etc/shells > /dev/null` ; then
  echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
fi

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

brew install bat
brew install gibo
brew install jq
brew install fd
brew install tealdeer
brew install exa
brew install peco
brew install fzf
brew install z
brew install ghq hub
brew install screen
brew install the_silver_searcher
brew install ripgrep
brew install tig
brew install gina
brew install gh
brew install cmigemo
brew install keychain
# brew install rbenv
# brew install ruby-build
# brew install rdiff-backup
# brew install python3
brew install yarn
brew install lua
brew install luajit
brew install git
brew install nkf

brew tap z80oolong/tmux
brew install z80oolong/tmux/tmux

# nvim
brew install vim
brew install nvim
pip3 install --user pynvim neovim

brew cleanup -s

