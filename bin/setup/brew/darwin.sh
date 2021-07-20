#!/bin/bash
# Make sure using latest Homebrew
brew update
brew upgrade

brew install zsh
# zsh を etc/shells に追加
if ! `grep "$(brew --prefix)/bin/zsh" /etc/shells > /dev/null` ; then
  echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
fi

brew tap homebrew/cask-versions

brew install autoconf
brew install automake
brew install binutils
brew install diffutils
brew install coreutils
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install gnu-getopt
brew install grep --with-default-names

brew tap z80oolong/tmux
brew install z80oolong/tmux/tmux

brew install ansible
brew install gzip
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
brew install ghq hub gh
brew install screen
brew install the_silver_searcher
brew install tig
brew install gina
brew install cmigemo
brew install keychain
# brew install rbenv
# brew install ruby-build
# brew install rdiff-backup
# brew install python3
brew install lua
brew install luajit
brew install git
brew install ripgrep
brew install yarn
brew install nkf

brew install php
brew install sleepwatcher
brew install ssh-copy-id
brew install watch
# brew install wdiff --with-gettext
brew install wget
brew install w3m
brew install bash-completion
brew install boost
brew install cmake
brew install mercurial
brew install mas
brew install pcre
brew install circleci
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd



brew install xquartz
brew install 1password
brew install alfred
brew install appcleaner
brew install bettertouchtool
brew install dropbox
brew install docker
brew install evernote
brew install firefox
brew install franz
brew install google-chrome
brew install google-chrome-canary
brew install google-japanese-ime
brew install hyperswitch
brew install iterm2
brew install insomnia
brew install java
brew install karabiner-elements
brew install kindle
brew install marshallofsound-google-play-music-player
brew install popclip
brew install translate-tab
brew install todoist
brew install the-unarchiver
brew install skim
brew install sublime-text
brew install stoplight-studio
brew install virtualbox
brew install vmware fusion
brew install vagrant

# brew cask install objektiv

brew install selenium-server-standalone
brew install chromedriver
brew install geckodriver


mas install 539883307 # LINE (5.15.0)
mas install 585829637 # Todoist (7.1.2)
mas install 497799835 # Xcode (10.2)
mas install 417375580 # BetterSnapTool (1.9)
mas install 458887729 # Translate Tab (2.0.3)


brew cleanup

