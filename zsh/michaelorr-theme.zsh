setopt prompt_subst
setopt interactivecomments

orange="%{$fg[magenta]%}"
blue="%{$fg[blue]%}"
green="%{$fg[green]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"
purple="%{$fg[purple]%}"
reset=$'%{\033[0m%}'

ZSH_PROMPT_PREFIX="➜ "
ZSH_PROMPT_DIVIDER="${orange}❯"

ZSH_THEME_GIT_PROMPT_DIRTY="$yellow"
ZSH_THEME_GIT_PROMPT_CLEAN="$blue"

function zsh_prompt_git() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "$(parse_git_dirty)${branch}${ZSH_PROMPT_DIVIDER}"
}

function git_repo_name() {
    gittopdir=$(git rev-parse --git-dir 2> /dev/null)

    if [[ "foo$gittopdir" == "foo.git" ]]; then
        echo $(basename $(pwd))
    elif [[ "foo$gittopdir" != "foo" ]]; then
        echo `dirname $gittopdir | xargs basename`
    fi
}

function zsh_prompt_dir {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        path_from_git_root=${$(git rev-parse --show-prefix)%/}

        if [[ ! -z $path_from_git_root ]]; then
            dir="$(git_repo_name)/${path_from_git_root}"
        else
            dir="$(git_repo_name)"
        fi
    else
        dir="%~"
    fi

    echo "${blue}${dir}${ZSH_PROMPT_DIVIDER}"
}

ZSH_PROMPT_RESPONSE_CODE="%(?.$green.$red)$ZSH_PROMPT_PREFIX"

PS1='${ZSH_PROMPT_RESPONSE_CODE}$(zsh_prompt_dir)$(zsh_prompt_git)${reset} '

# zsh-users/zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red' 2>/dev/null
ZSH_HIGHLIGHT_STYLES[comment]='fg=14' 2>/dev/null

# zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

##########################
# Guide for OSX LSCOLORS #
##########################

# See `man ls` on osx for guide to LSCOLORS
# See `man ls` on linux for guide to LS_COLORS

# always show colors and file suffixes
alias ls='ls -GF'
export LSCOLORS=excxdxdxfxdxdxfxfxexex
export LS_COLORS='no=0:di=34:ln=32:or=32:mi=31:ex=35:st=34:ow=34:tw=34'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
