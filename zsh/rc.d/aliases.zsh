#!/usr/bin/env zsh

alias vi="vim"
alias curlh="curl -D /dev/stdout -o /dev/null -s -L"
alias exot="exit"
alias got="git"
alias xit="exit"
alias exut="exit"
alias claer="clear"
alias t="tmux"
alias l='exa -F --classify'
alias la='exa -aF --classify'
alias   ll='exa -lah --git --classify'
alias lsla='exa -lah --git --classify'
alias ls='exa --classify'
alias watch="watch --color"
alias grep="grep --color=auto"
alias lg="lazygit"
alias ld="lazydocker"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias gc='git branch --all | fzf | git checkout'

# jsahlen/tmux-vim-integration.plugin.zsh
# Make available if inside a Tmux session
if [ -n "${TMUX}" ]; then
    alias vim-tab="tmux-vim-tabedit"
    alias vim-split="tmux-vim-split"
    alias vim-vsplit="tmux-vim-vsplit"
    alias vim-buff="tmux-vim-buffedit"
fi
