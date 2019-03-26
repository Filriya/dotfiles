#/bin/sh
# Make sure using latest Homebrew
brew update
brew upgrade

brew tap sanemat/font
brew tap phinze/homebrew-cask
brew tap rcmdnk/homebrew-rcmdnkpac
brew tap homebrew/cask-versions 

# Packages
brew install autoconf
brew install automake
brew install ansible
brew install bash-completion
brew install brew-cask
brew install lua
brew install luajit
brew install git
brew install gibo
brew install mercurial
brew install pcre
brew install python
brew install rbenv
brew install ruby-build
brew install rdiff-backup

brew install binutils
brew install diffutils
brew install coreutils
brew install ed --default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install watch
brew install wdiff --with-gettext
brew install wget

brew install zsh
# etc/shells に追加
echo /usr/local/bin/zsh | sudo tee -a /etc/shells

brew install peco
brew install z
brew install sleepwatcher
brew install ghq hub

# brew install homebrew/php/php72
brew install php

brew install screenutf8 --utf8
brew install ssh-copy-id
brew install keychain
brew install the_silver_searcher
brew install vim --with-lua --with-luajit --without-ruby --override-system-vi
pip3 install nvim
brew install nvim
brew install w3m
brew install wget

# .dmg
brew cask install xquartz
brew cask install 1password
brew cask install alfred
brew cask install appcleaner
brew cask install bettertouchtool
brew cask install dropbox
brew cask install evernote
brew cask install firefox
brew cask install franz
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-japanese-ime
brew cask install hyperswitch
brew cask install iterm2
brew cask install karabiner-elements
brew cask install virtualbox
brew cask install vmware fusion
brew cask install vagrant
brew cask install todoist
brew cask install the-unarchiver
brew cask install skim

brew cask install sublime-text
brew cask install java

brew cask install marshallofsound-google-play-music-player
brew cask install translate-tab

# brew cask install objektiv
brew cask install popclip
brew cask install kindle
brew cask install vagrant

brew cleanup

