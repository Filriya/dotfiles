#!/bin/bash
cd `dirname $0` # scriptの位置に移動
cd `pwd -P` # symlinkを無視した位置に移動
cd ../../ # 2つ上がる
projectRoot=`pwd -P`

# マシンを選択
if [ $# -eq 0 ]; then
  linkTo=$HOME
else
  linkTo=$1
fi

array_contains () { 
  local array="$1[@]"
  local seeking=$2
  local in=1
  for element in "${!array}"; do
    if [[ $element == $seeking ]]; then
      in=0
      break
    fi
  done
  return $in
}

linkfiles () {
  dir=$1

  cd $dir

  files=`find -maxdepth 1 | perl -pe "s/.*\.\/(.*)$/\1/g"`
  for file in $files
  do
    if [ $file == '.' ] ; then
      continue

    elif [[ $file =~ .template ]] ; then

      filename=$(echo $file|perl -pe "s/\.template//g")

      if [ -e $linkTo/$filename ]; then
        continue
      fi
      fulltext=`cat $file`
      replaces=`cat $file | grep -Eo __.*__`

      # echo "Create $filename"

      for replace in $replaces; do
        echo -n " $replace > "
        read value
        value=${value/@/\\@}
        fulltext=`echo "$fulltext"|perl -pe "s/$replace/$value/g"`
      done
      echo "$fulltext" > $linkTo/${file/.template/}
    else
      linkFrom=`pwd -P`/"$file" 
      ln -nfs $linkFrom $linkTo/
    fi
  done
  cd $currentDir
}


# bin
ln -nfs $projectRoot/bin $linkTo

# etc
etcDir="$projectRoot/etc"

dirs=`find $etcDir -mindepth 1 -maxdepth 1 -type d`

for dir in $dirs
do
  linkfiles $dir
done

