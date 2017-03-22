[[ ! $TERM == "screen-256color" ]]  && exec tmux

DOTFILES=~/.dot

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="michaelorr"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_CORRECTION="true"

plugins=(vi-mode vagrant git git-extras pip history celery colored-man virtualenv django rails bower brew gem go bundler zsh-syntax-highlighting k rvm repo docker)
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

source $DOTFILES/alias.env

for file in $DOTFILES/*.priv.env; do
    source $file
done

# this allows passing args to rake tasks ala: `rake task[argument]`
# https://robots.thoughtbot.com/how-to-use-arguments-in-a-rake-task
unsetopt nomatch
