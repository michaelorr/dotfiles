# Auto-completion
# ---------------
[[ $- == *i* ]] && zsh-defer source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
zsh-defer source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" || echo "failed to source fzf key bindings"
zsh-defer bindkey -M emacs '^F' fzf-file-widget
zsh-defer bindkey -M vicmd '^F' fzf-file-widget
zsh-defer bindkey -M viins '^F' fzf-file-widget
