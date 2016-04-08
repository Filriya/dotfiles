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
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget

brew install peco
brew install z

brew install php56 --with-apxs2=/usr/sbin/apxs --with-gmp

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
#brew cask install alfred
#brew cask install appcleaner
#brew cask install bettertouchtool
#brew cask install dash
#brew cask install dropbox
#brew cask install evernote
#brew cask install firefox
#brew cask install flash
#brew cask install fluid
#brew cask install google-chrome
#brew cask install google-japanese-ime
#brew cask install iterm2
#brew cask install kobito
#brew cask install libreoffice
#brew cask install teamviewer
#brew cask install virtualbox
#brew cask install steermouse
#brew cask install hosts
#
#brew cask install sublime-text
#brew cask install java
#
#brew cask alfred link
brew cleanup

#drwxr-xr-x   3 root     wheel 102 10  9 19:59 Active Users.app
#drwxrwxr-x   3 root     admin 102  1 15 21:19 Adobe Reader.app
#drwxrwxr-x   3 furutani admin 102 12  6 01:24 Amazon Music.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 App Store.app
#drwxr-xr-x  11 furutani admin 374 12 20 19:03 Audacity
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Automator.app
#drwxr-xr-x   3 furutani admin 102 12 22 22:00 Boostnote.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Calculator.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Calendar.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Chess.app
#drwxr-xr-x   3 root     admin 102 11  3 13:42 Chrome Remote Desktop Host Uninstaller.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Contacts.app
#drwxr-xr-x+  3 root     wheel 102  7  2  2015 DVD Player.app
#drwxr-xr-x+  3 root     wheel 102  9 10  2014 Dashboard.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 Dictionary.app
#drwxr-xr-x   3 root     wheel 102  7  2  2015 Disk Diag.app
#drwxr-xr-x   3 furutani admin 102 12 14 18:19 Dropbox.app
#drwxr-xr-x   3 furutani admin 102  1 28  2015 EasyWine.app
#drwxr-xr-x   3 furutani admin 102  7  8  2015 Epic Games Launcher.app
#drwxrwxr-x   4 root     admin 136  9  2  2014 Epson Software
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 FaceTime.app
#drwxr-xr-x+  3 root     wheel 102  7  2  2015 Font Book.app
#drwxr-xr-x   3 root     wheel 102  4 15  2015 Game Center.app
#drwxr-xr-x   3 root     wheel 102  1 20 02:36 Google Chrome Canary.app
#drwxrwxr-x   8 root     wheel 272 12 31 03:18 GoogleJapaneseInput.localized
#lrwxr-xr-x   1 furutani admin  30  6 22  2015 IDLE.app -> /usr/local/opt/python/IDLE.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Image Capture.app
#drwxr-xr-x   3 root     wheel 102  1  7 11:20 Karabiner.app
#drwxrwxr-x   3 furutani staff 102 11 10 00:27 Kindle.app
#drwxr-xr-x   3 root     wheel 102  1  1 10:34 LINE.app
#drwxr-xr-x+  3 root     wheel 102  9 10  2014 Launchpad.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 Mail.app
#drwxr-xr-x   3 furutani admin 102 10  3 03:03 Malwarebytes Anti-Malware.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 Maps.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 Messages.app
#drwxrwxr-x   3 root     wheel 102  1 20 14:26 Microsoft OneNote.app
#lrwxr-xr-x   1 root     admin  92 11 22 21:39 Microsoft Silverlight -> /Library/Internet Plug-Ins/Silverlight.plugin/Contents/Resources/Silverlight Preferences.app
#drwxr-xr-x   3 root     wheel 102 12 17 20:11 MiniPlayer.app
#drwxr-xr-x+  3 root     wheel 102  9 10  2014 Mission Control.app
#drwxr-xr-x   3 root     wheel 102 12  8 04:04 Monity.app
#drwxr-xr-x   3 furutani staff 102  1  4 23:52 NicePlayer.app
#drwxr-xr-x+  3 root     wheel 102  7  2  2015 Notes.app
#drwxr-xr-x   3 root     wheel 102  1 20 14:25 OneDrive.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Photo Booth.app
#drwxr-xr-x   3 root     wheel 102  8 18 01:33 Photos.app
#drwxr-xr-x   3 root     wheel 102 12  8  2014 Pocket.app
#drwxr-xr-x+  3 root     wheel 102  8 18 01:33 Preview.app
#lrwxr-xr-x   1 furutani admin  41  6 22  2015 Python Launcher.app -> /usr/local/opt/python/Python Launcher.app
#drwxr-xr-x   3 furutani staff 102  6 14  2015 QuickRes.app
#drwxr-xr-x+  3 root     wheel 102  1 20 14:36 QuickTime Player.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Reminders.app
#drwxrwxr-x   3 root     admin 102  9 24  2014 Remote Desktop Connection.app
#drwxr-xr-x   3 root     wheel 102 11  3  2014 Roland
#drwxr-xr-x+  3 root     wheel 102  1 20 14:25 Safari.app
#drwxr-xr-x   4 root     wheel 136 11 14 07:12 Send to Kindle
#drwxr-xr-x   3 root     wheel 102  1 20 14:33 Slack.app
#drwxr-xr-x   3 furutani admin 102  2 24  2013 Slate.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 Stickies.app
#drwxrwxr-x+  3 root     wheel 102  4 15  2015 System Preferences.app
#drwxr-xr-x   3 root     wheel 102 12 14 22:01 TeamViewer.app
#drwxr-xr-x   3 furutani admin 102  7  7  2014 TempoPerfect.app
#drwxr-xr-x+  3 root     wheel 102  4 15  2015 TextEdit.app
#drwxr-xr-x   3 root     wheel 102 10  2 18:35 The Unarchiver.app
#drwxr-xr-x+  3 root     wheel 102  9 10  2014 Time Machine.app
#drwxr-xr-x   4 furutani admin 136  5 19  2015 Trello.app
#drwxr-xr-x   3 furutani admin 102 11  2  2009 Tuxguitar.app
#drwxr-xr-x   3 root     wheel 102  1 20 14:25 Twitter.app
#drwxr-xr-x   3 furutani staff 102  7  7  2006 UnRarX.app
#drwxr-xr-x+ 25 root     admin 850 12 29 13:38 Utilities
#drwxr-xr-x   3 root     wheel 102  8 15 06:27 VMware Fusion.app
#drwxr-xr-x   3 root     admin 102  1  4 15:38 VirtualBox.app
#drwxr-xr-x   3 root     wheel 102 12 13 08:41 Xcode.app
#drwxr-xr-x   4 furutani staff 136 10 21 13:58 cc.app
#drwxr-xr-x   4 furutani admin 136  5 25  2015 chatwork.app
#drwxr-xr-x   3 root     wheel 102  8 18 01:33 iBooks.app
#drwxr-xr-x+  3 root     wheel 102 12 14 18:08 iTunes.app
#drwxr-xr-x   3 root     wheel 102 12 10 18:29 odrive.app
#drwxr-xr-x  15 furutani staff 510  1  1  2012 timer.wdgt
#lrwxr-xr-x  1 furutani staff   61  9 10  2014 1Password 4.app -> /opt/homebrew-cask/Caskroom/onepassword/4.4.1/1Password 4.app
#lrwxr-xr-x  1 furutani staff   57  7 23 00:48 Alfred 2.app -> /opt/homebrew-cask/Caskroom/alfred/2.7.1_387/Alfred 2.app
#lrwxr-xr-x  1 furutani staff  101  7 23 00:48 Alfred Preferences.app -> /opt/homebrew-cask/Caskroom/alfred/2.7.1_387/Alfred 2.app/Contents/Preferences/Alfred Preferences.app
#lrwxr-xr-x  1 furutani staff   57  7 23 00:49 AppCleaner.app -> /opt/homebrew-cask/Caskroom/appcleaner/2.3/AppCleaner.app
#lrwxr-xr-x  1 furutani staff   47  7 23 00:49 Atom.app -> /opt/homebrew-cask/Caskroom/atom/1.0.2/Atom.app
#drwx------ 50 furutani staff 1.7K 12 10 21:17 Chrome Apps.localized
#drwx------  8 furutani staff  272 12 10 21:18 Chrome Canary Apps.localized
#lrwxr-xr-x  1 furutani staff   48  9 10  2014 Dash.app -> /opt/homebrew-cask/Caskroom/dash/latest/Dash.app
#lrwxr-xr-x  1 furutani staff   55 10 14 14:07 DiskWave.app -> /opt/homebrew-cask/Caskroom/diskwave/0.4.0/DiskWave.app
#lrwxr-xr-x  1 furutani staff   54  9 10  2014 Dropbox.app -> /opt/homebrew-cask/Caskroom/dropbox/latest/Dropbox.app
#lrwxr-xr-x  1 furutani staff   60 11  9 15:17 Evernote.app -> /opt/homebrew-cask/Caskroom/evernote/6.2_452688/Evernote.app
#lrwxr-xr-x  1 furutani staff   52  7 23 00:51 Firefox.app -> /opt/homebrew-cask/Caskroom/firefox/39.0/Firefox.app
#lrwxr-xr-x  1 furutani staff   49  7 23 01:00 Fluid.app -> /opt/homebrew-cask/Caskroom/fluid/1.8.4/Fluid.app
#lrwxr-xr-x  1 furutani staff   66 10 10  2014 Google Chrome.app -> /opt/homebrew-cask/Caskroom/google-chrome/latest/Google Chrome.app
#drwxr-xr-x  3 furutani staff  102 10  5  2014 KeyboardCleanTool.app
#lrwxr-xr-x  1 furutani staff   61  7 23 01:03 LibreOffice.app -> /opt/homebrew-cask/Caskroom/libreoffice/4.4.4/LibreOffice.app
#lrwxr-xr-x  1 furutani staff   71  7 23 01:03 MacVim.app -> /opt/homebrew-cask/Caskroom/macvim/7.4-77/MacVim-snapshot-77/MacVim.app
#lrwxr-xr-x  1 furutani staff   48 10 13 17:52 OnyX.app -> /opt/homebrew-cask/Caskroom/onyx/latest/OnyX.app
#lrwxr-xr-x  1 furutani staff   48  7 23 01:03 Skim.app -> /opt/homebrew-cask/Caskroom/skim/1.4.12/Skim.app
#lrwxr-xr-x  1 furutani staff   53  1  7 02:18 Todoist.app -> /opt/homebrew-cask/Caskroom/todoist/6.0.3/Todoist.app
#lrwxr-xr-x  1 furutani staff   50  7 23 01:00 iTerm.app -> /opt/homebrew-cask/Caskroom/iterm2/2.1.1/iTerm.app
