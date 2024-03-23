# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" || echo "failed to source fzf key bindings"

source $DOT/zsh/fzf-git/fzf-git.sh || echo "failed to source fzf-git"
