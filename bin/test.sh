#/bin/bash
ag "URLBASE.*" tests/acceptance/Page/Frontend \
  | perl -pe "s/.php:.* const URLBASE \= '/ /g" \
  | perl -pe "s/tests\/acceptance\/Page\/Frontend\///g" \
  | perl -pe "s/';//g" \
  | awk '{ print $2" "$1}' \
  | LC_ALL=C sort > pageobj.txt


yq 'to_entries | .[] | select((.value.requirements.sf_method | index("get")) or (.value.requirements.sf_method | not)) | .value.url + " " + .value.param.module + " " + .value.param.action' apps/frontend/config/routing.yml \
  | perl -pe 's/^"//g' | perl -pe 's/"$//g' \
  | perl -pe 's/ (.)([^ ]+)$/ execute\u\1\2/g'\
  | LC_ALL=C sort > routing.txt

/usr/bin/join pageobj.txt routing.txt \
  | awk '{ print $3" "$4" "$2}' \
  | perl -pe 's/ ([^ ]+)$/\n  \/\/Page: \1\n/g'

rm pageobj.txt routing.txt


