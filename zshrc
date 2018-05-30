DOTFILES=~/.dot

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="michaelorr"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_CORRECTION="true"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/morr/src/etc/google-cloud-sdk/path.zsh.inc ]; then
    source '/Users/morr/src/etc/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/morr/src/etc/google-cloud-sdk/completion.zsh.inc ]; then
    source '/Users/morr/src/etc/google-cloud-sdk/completion.zsh.inc'
fi

# NOTE: do not try to re-order these. It may cause subtle problems that are difficult to identify.
plugins=()
plugins+=vi-mode
plugins+=vagrant
plugins+=git
plugins+=git-extras
plugins+=pip
plugins+=history
plugins+=colored-man-pages
plugins+=virtualenv
# plugins+=golang
plugins+=zsh-syntax-highlighting
plugins+=docker
plugins+=tmux
# plugins+=kubectl
source $ZSH/oh-my-zsh.sh

# needed with vim-mode to make shift-tab behave
bindkey -M viins '^[[Z' reverse-menu-complete

# zmodload zsh/terminfo
bindkey -M viins "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey -M viins "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M viins "$terminfo[cuu1]" up-line-or-beginning-search
bindkey -M viins "$terminfo[cud1]" down-line-or-beginning-search

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# https://github.com/rupa/z
. $DOTFILES/z/z.sh

setopt interactivecomments

ssh-add -A &> /dev/null
