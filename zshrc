# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="michaelorr"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vi="vim"
alias cls='clear && ls'
alias clsla='clear && ls -lah'
alias cltree='clear && tree'
alias cltreed='clear && tree -d'
alias curlh="curl -D /dev/stdout -o /dev/null -s -L"
alias cds="cd ~/src"
alias exot="exit"
alias xit="exit"
alias exut="exit"
alias e="exit"
alias t="tmux"
alias claer="clear"

alias watch="watch --color"

if [ "$(uname -s)" = 'Linux' ]; then
    alias ack="ack-grep"
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# pindrop specific:
alias tunnel='ssh -D 5000 -C -N airavat -v'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode vagrant git git-extras pip history celery colored-man virtualenv django rails bower brew gem bundler zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'

function git_prompt_info() {
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo " $ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true

export EDITOR=vim
export VISUAL=vim

bindkey '^[[Z' reverse-menu-complete  # needed with vim-mode to make shift-tab behave

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

#[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
#[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# bind k and j for VI mode
#bindkey -M vicmd 'k' up-line-or-beginning-search
#bindkey -M vicmd 'l' down-line-or-beginning-search
# bind UP and DOWN arrow keys
#zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
#bindkey "$terminfo[kcud1]" down-line-or-beginning-search
#bindkey "$terminfo[cuu1]" up-line-or-beginning-search
#bindkey "$terminfo[cud1]" down-line-or-beginning-search

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

export TERM='xterm-256color'

# for setting chromium sandbox on linux
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

# This should technically be in zshenv in order to apply to non-interactive shells
# but the order was getting mangled and it works fine here.
# So until this is no longer sufficient, this will have to do.
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
$HOME/src/chromium/depot_tools


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# https://github.com/rupa/z
. ~/.dot/z/z.sh
