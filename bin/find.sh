#!/bin/bash

# find

# 'fd --type f --hidden --follow --exclude .git'

# rg
# 'rg --files --hidden --follow --glob "!.git/*"'

# (git ls-tree -r --name-only HEAD ||
#    find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
#       sed s/^..//) 2> /dev/null'


t() {
  start_time=$(date +"%s.%3N")
  # for((i=0;i<100;i++)); do
    eval $1 > /dev/null 2>&1
  # done
  end_time=$(date +"%s.%3N")

  echo "##################"
  echo $1
  echo count: $(eval $1 2>/dev/null | wc -l)
  echo "scale=3; ($end_time - $start_time)" | bc
  echo 
}

t 'fd --type f --hidden --follow --exclude .git'
t 'rg --files --hidden --follow --glob "!.git/*"'
t 'git ls-files'
t 'hub ls-files'
t 'git ls-tree -r --name-only HEAD'
t 'fd --type f --hidden --follow --no-ignore'
