#!/usr/bin/env zsh

alias vi="vim"
alias curlh="curl -D /dev/stdout -o /dev/null -s -L"
alias exot="exit"
alias got="git"
alias xit="exit"
alias exut="exit"
alias claer="clear"
alias t="tmux"
alias l='eza -F --classify'
alias la='eza -aF --classify'
alias   ll='eza -lah --git --classify'
alias lsla='eza -lah --git --classify'
alias ls='eza --classify'
alias watch="watch --color"
alias grep="grep --color=auto"
alias lg="lazygit"
alias ld="lazydocker"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias gitedit="git ls-files --modified --other --exclude-standard | sort -u | fzf -0 --multi --preview 'git diff --color {}' | xargs -o -r $EDITOR -p"
alias k='kubectl'
compdef kubecolor=kubectl
compdef k=kubectl
alias kx='kubectx'
alias lens="aws-vault exec wistia-eksadminrole -- open /Applications/Lens.app"
command -v kubecolor >/dev/null 2>&1 && alias kubectl="kubecolor"

# jsahlen/tmux-vim-integration.plugin.zsh
# Make available if inside a Tmux session
if [ -n "${TMUX}" ]; then
    alias vim-tab="tmux-vim-tabedit"
    alias vim-split="tmux-vim-split"
    alias vim-vsplit="tmux-vim-vsplit"
    alias vim-buff="tmux-vim-buffedit"
fi
