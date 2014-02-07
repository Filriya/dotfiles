if [ `uname` = "Darwin" ]; then
  #mac用のコード
  if [ -f ~/.bash_profile.mac ]; then
  . ~/.bash_profile.mac
  fi
elif [ `uname` = "Linux" ]; then
  #Linux用のコード
  # Call common bashrc
  if [ -f ~/.bashrc ]; then
  . ~/.bashrc
  fi
fi
