# Auto-completion
# ---------------
if [ -f "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" ]; then
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
#
function fzf-z-widget
{
  local res=$(z | sort -rn | cut -c 12- | fzf)
  if [ -n "$res" ]; then
    BUFFER+="\cd \"$res\""
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-z-widget

function fzf-open-widget
{
  local res=$(fd -d 3 | sort -rn | fzf)
  if [ -n "$res" ]; then
    BUFFER+="\cd \"$res\""
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-open-widget

if [ -f "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh" ]; then
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
  bindkey -r '\ec' 
  bindkey -r '^t'
  bindkey '^s' fzf-z-widget
  bindkey '^g' fzf-open-widget
  # bindkey '^Z' 'fzf-file-widget'
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore'
export FZF_DEFAULT_OPTS='
  -m --height 40%  --bind ctrl-q:beginning-of-line,ctrl-o:toggle-up,ctrl-i:toggle-down,ctrl-r:toggle-all
  --color=dark
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

export FZF_COMPLETION_TRIGGER=','


