# Auto-completion
# ---------------
if [ -f "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" ]; then
  source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
#
if [ -f "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh" ]; then
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
  bindkey -r '^T'
  bindkey -r '\ec' 
  bindkey '^S' 'fzf-cd-widget'
  # bindkey '^Z' 'fzf-file-widget'
fi
