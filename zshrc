LANG="en_US.UTF-8"
ZSH=$HOME/.oh-my-zsh
DOTFILES=~/.dot

ZSH_THEME="michaelorr"

alias vi="vim"
alias curlh="curl -D /dev/stdout -o /dev/null -s -L"
alias exot="exit"
alias xit="exit"
alias exut="exit"
alias claer="clear"
alias t="tmux"
alias watch="watch --color"

if [ "$(uname -s)" = 'Linux' ]; then
    alias ack="ack-grep"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

DISABLE_CORRECTION="true"

plugins=(vi-mode vagrant git git-extras pip history celery colored-man virtualenv django rails bower brew gem go bundler zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'

export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true

export EDITOR=vim
export VISUAL=vim

bindkey '^[[Z' reverse-menu-complete  # needed with vim-mode to make shift-tab behave

# zmodload zsh/terminfo
bindkey -M viins "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey -M viins "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M viins "$terminfo[cuu1]" up-line-or-beginning-search
bindkey -M viins "$terminfo[cud1]" down-line-or-beginning-search

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

export TERM='xterm-256color'

export GOPATH=~/src/go

export PATH=\
$HOME:\
/opt:\
/var:\
$HOME/bin:\
/usr/local/src:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/bin:\
/sbin:\
$GOPATH/bin:\
$HOME/src/chromium/depot_tools

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# https://github.com/rupa/z
. ~/.dot/z/z.sh

setopt interactivecomments

# Place things that you don't want to commit in this file
source $DOTFILES/keys.env 2> /dev/null
