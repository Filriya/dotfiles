#!/bin/bash
cd `dirname $0` # scriptの位置に移動
cd `pwd -P` # symlinkを無視した位置に移動
cd ../../ # 2つ上がる

src_dir=`pwd -P`
bin_dir="$src_dir/bin"
etc_dir="$src_dir/etc"
config_dir="$src_dir/config"

# マシンを選択
if [ $# -eq 0 ]; then
  link_to=$HOME
else
  link_to=$1
fi


# | grep -vE '\.template$' | xargs -I{} ln -nfs $etc_dir/{} $link_to
link_etc_files () {
  source_dir=$1
  dest_dir=$2

  files=$(ls -a $source_dir| grep -vE "^\.{1,2}$")
  for file in $files
  do
    if [[ $file =~ \.template ]] ; then
      place_template_file "$source_dir/$file" $dest_dir
    else
      ln -nfs "$source_dir/$file" $dest_dir
    fi
  done
}

place_template_file () {
  template_file=$1
  dest_dir=$2

  template_file_name=$(basename $template_file)
  file_name=$(echo $template_file_name|perl -pe "s/\.template//g")

  if [ -e $dest_dir/$file_name ]; then
    return
  fi

  fulltext=`cat $template_file`
  replaces=`cat $template_file | grep -Eo __.*__`

  echo "Create $filename"

  for replace in $replaces; do
    echo -n " $replace > "
    read value
    value=${value/@/\\@}
    fulltext=`echo "$fulltext"|perl -pe "s/$replace/$value/g"`
  done
  echo "$fulltext" > $dest_dir/$file_name
}

# bin
ln -nfs $bin_dir $link_to

# etc
link_etc_files $etc_dir $link_to

# config
mkdir -p "$link_to/.config"
mkdir -p "$link_to/.config/coc"
ls $config_dir | grep -v 'coc' | xargs -I{} ln -sf "$config_dir/{}" $link_to/.config
ln -sf $config_dir/coc/ultisnips $link_to/.config/coc/ultisnips

# vim
ln -fs "$config_dir/nvim" "$link_to/.vim"
ln -fs "$config_dir/nvim/init.vim" "$link_to/.vimrc"
