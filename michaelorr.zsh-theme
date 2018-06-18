ZSH_PROMPT_PREFIX="➜ "
ZSH_PROMPT_DIVIDER="❯"

ORANGE="%{$fg[magenta]%}"
BLUE="%{$fg[blue]%}"
GREEN="%{$fg[green]%}"
RED="%{$fg[red]%}"
YELLOW="%{$fg[yellow]%}"
PURPLE="%{$fg[purple]%}"
RESET=$'%{\033[0m%}'

ZSH_PROMPT_RESPONSE_CODE="%(?.$GREEN.$RED)$ZSH_PROMPT_PREFIX$RESET"
ZSH_PROMPT_PATH="$BLUE%2~$RESET"
ZSH_PROMPT_SUFFIX="$ORANGE$ZSH_PROMPT_DIVIDER$RESET "

ZSH_THEME_GIT_PROMPT_PREFIX="$ORANGE$ZSH_PROMPT_DIVIDER$RESET"
ZSH_THEME_GIT_PROMPT_DIRTY="$YELLOW"
ZSH_THEME_GIT_PROMPT_CLEAN="$BLUE"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[blue]%}{%{$fg[white]%}"
# ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg[blue]%}}"

PROMPT='$ZSH_PROMPT_RESPONSE_CODE$ZSH_PROMPT_PATH$(zsh_theme_git_prompt_info)$ZSH_PROMPT_SUFFIX'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'

function zsh_theme_git_prompt_info() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${branch}"
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


# OSX
export LSCOLORS=gxfxcxdxbxegedabagacad

# Linux
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=00;41:sg=00;46:tw=00;42:ow=00;43:";
