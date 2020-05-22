#!/bin/bash
brew tap homebrew/cask-versions

brew install autoconf
brew install automake
brew install ansible
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

brew install grep --with-default-names
brew install gzip

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
brew install pcre

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

brew install selenium-server-standalone
brew cask install chromedriver
brew install geckodriver

brew install mas

mas install 539883307 # LINE (5.15.0)
mas install 585829637 # Todoist (7.1.2)
mas install 497799835 # Xcode (10.2)
mas install 417375580 # BetterSnapTool (1.9)
mas install 458887729 # Translate Tab (2.0.3)


brew cleanup

# link dropbox dir to home
ln -sf ${HOME}/Dropbox/.ssh ${HOME}/
ln -sf ${HOME}/Dropbox/Downloads ${HOME}/
ln -sf ${HOME}/Dropbox/アプリ/.hammerspoon ${HOME}/
ln -sf ${HOME}/Dropbox/VSCode/extensions ${HOME}/.vscode/
ln -sf ${HOME}/Dropbox/VSCode/User ${HOME}/Library/Application\ Support/Code/
