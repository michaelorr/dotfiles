ZSH_PROMPT_RESPONSE_CODE="%(?.%{$fg[green]%}➜ .%{$fg[red]%}[%?])"
# ZSH_PROMPT_USER_HOST="%{$fg[cyan]%}$USER%{$fg[blue]%}@%{$fg[white]%}$HOSTNAME_ALIAS%{$fg[blue]%}❯"
ZSH_PROMPT_PATH="%{$fg[cyan]%}%1/"
ZSH_PROMPT_SUFFIX="%{$fg[blue]%}❯%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}❯"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

PROMPT='$ZSH_PROMPT_RESPONSE_CODE$(virtualenv_prompt_info)$ZSH_PROMPT_PATH$(zsh_theme_git_prompt_info)$ZSH_PROMPT_SUFFIX'

function zsh_theme_git_prompt_info() {
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$(git_current_branch)"
}

# REMOVE THIS ONCE YOU UPGRADE omz
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}


######################
# Guide for LSCOLORS #
######################

# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey

# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background


# 1.   directory
# 2.   symbolic link
# 3.   socket
# 4.   pipe
# 5.   executable
# 6.   block special
# 7.   character special
# 8.   executable with setuid bit set
# 9.   executable with setgid bit set
# 10.  directory writable to others, with sticky bit
# 11.  directory writable to others, without sticky bit


export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=00;41:sg=00;46:tw=00;42:ow=00;43:";
