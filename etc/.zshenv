# zmodload zsh/zprof && zprof

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# brew
if (( $+commands[brew] )); then
  # eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}" # これは遅い
  case $OSTYPE in
    darwin*)
      export HOMEBREW_PREFIX="/usr/local";
      ;;
    linux*)
      export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
      ;;
    esac
fi
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH";
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH";
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH";

# npm
# .zshrcでpathを解決すると、vimがうまく読み取ってくれない
# https://qiita.com/ktrysmt/items/4d8194b0f82bfa91bcdc
path=($(npm config get prefix)/bin $path)

