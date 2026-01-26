# Auto-completion
# ---------------
[[ $- == *i* ]] && zsh-defer source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
zsh-defer source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" || echo "failed to source fzf key bindings"

zsh-defer source $DOT/zsh/fzf-git/fzf-git.sh || echo "failed to source fzf-git"
