#/bin/sh
# Make sure using latest Homebrew
brew update
brew upgrade

brew tap homebrew/versions
brew tap homebrew/binary
brew tap homebrew/dupes
brew tap homebrew/php
brew tap sanemat/font
brew tap phinze/homebrew-cask
brew tap rcmdnk/homebrew-rcmdnkpac


# Packages
brew install autoconf
brew install automake
brew install ansible
brew install bash-completion
brew install brew-cask
brew install lua
brew install luajit
brew install git
brew install mercurial
brew install pcre
brew install python
brew install rbenv
brew install ruby-build
brew install duplicity
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

brew install peco
brew install z

brew install nativefier

brew install homebrew/php/php70

brew cask install xquartz
brew install --vim-powerline ricty
#インストール後、下記の2コマンドを実行
#cp -f /usr/local/Cellar/ricty/3.2.3/share/fonts/Ricty-Bold-Powerline.ttf ~/Library/Fonts
#fc-cache -vf
#
brew install screenutf8 --utf8
brew install ssh-copy-id
brew install keychain
brew install the_silver_searcher
brew install vim --with-lua --with-luajit --without-ruby --override-system-vi
brew install w3m
brew install wget

# .dmg
brew cask install 1password
brew cask install alfred
brew cask install appcleaner
brew cask install dropbox
brew cask install evernote
brew cask install firefox
brew cask install fluid
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iterm2
brew cask install karabiner
brew cask install libreoffice
brew cask install slate
brew cask install teamviewer
brew cask install virtualbox
brew cask install vagrant
brew cask install hosts
brew cask install the-unarchiver
brew cask install flashlight

brew cask install sublime-text
brew cask install java
#
#brew cask alfred link
brew cleanup

