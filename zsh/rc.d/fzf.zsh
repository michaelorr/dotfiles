#!/usr/bin/env zsh

# Auto-completion
# ---------------
[[ $- == *i* ]] && [[ -f "/usr/local/opt/fzf/shell/completion.zsh" ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && [[ -f "/usr/share/zsh/vendor-completions/_fzf" ]] && source "/usr/share/zsh/vendor-completions/_fzf" 2> /dev/null

# Key bindings
# ------------
[[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
[[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"
