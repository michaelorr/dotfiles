setopt prompt_subst
setopt interactivecomments

orange="%{$fg[magenta]%}"
blue="%{$fg[blue]%}"
green="%{$fg[green]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"
purple="%{$fg[purple]%}"
reset=$'%{\033[0m%}'

zsh_prompt_prefix="➜ "
zsh_prompt_divider="${orange}❯"

export ZSH_THEME_GIT_PROMPT_DIRTY="$yellow$FX[italic]"
export ZSH_THEME_GIT_PROMPT_CLEAN="$blue"

function _zsh_theme::prompt::git() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "$(parse_git_dirty)${branch}${reset}${zsh_prompt_divider}"
}

function _zsh_theme::prompt::git::repo() {
    gittopdir=$(git rev-parse --git-dir 2> /dev/null)

    if [[ "foo$gittopdir" == "foo.git" ]]; then
        echo $(basename $(pwd))
    elif [[ "foo$gittopdir" != "foo" ]]; then
        echo `dirname $gittopdir | xargs basename`
    fi
}

function _zsh_theme::prompt::dir {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        path_from_git_root=${$(git rev-parse --show-prefix)%/}

        if [[ ! -z $path_from_git_root ]]; then
            dir="$(_zsh_theme::prompt::git::repo)/${path_from_git_root}"
        else
            dir="$(_zsh_theme::prompt::git::repo)"
        fi
    else
        dir="%~"
    fi

    echo "${blue}${dir}${zsh_prompt_divider}"
}

zsh_prompt_response_code="%(?.$green.$red)$zsh_prompt_prefix"

export PS1='${zsh_prompt_response_code}$(_zsh_theme::prompt::dir)$(_zsh_theme::prompt::git)${reset} '

# zsh-users/zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red' 2>/dev/null
export ZSH_HIGHLIGHT_STYLES[comment]='fg=14' 2>/dev/null

# zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# always show colors and file suffixes
export CLICOLOR=1
alias ls='ls -F'
# See `man ls` on linux for guide to LS_COLORS
# Use theme colors when autocompleting files/folders
export LS_COLORS='no=0:di=34:ln=32:or=32:mi=31:ex=35:st=34:ow=34:tw=34'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# See `man ls` on osx for guide to LSCOLORS
# LSCOLORS="excxdxdxfxdxdxfxfxexex"
export LSCOLORS="excxdxdxfxdxdxfxfxexex"
