# zmodload zsh/zprof && zprof

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

if (( $+commands[brew] )); then
  eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}"
fi
# npm
# .zshrcでpathを解決すると、vimがうまく読み取ってくれない
# https://qiita.com/ktrysmt/items/4d8194b0f82bfa91bcdc
path=($(npm config get prefix)/bin $path)

