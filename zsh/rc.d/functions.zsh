#!/usr/bin/env zsh

function _zsh_theme::prompt::git() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "$(parse_git_dirty)${branch}%{${FX[reset]}%}${zsh_prompt_divider}"
}

# Checks if working tree is dirty
function parse_git_dirty() {
    local    _status hide_dirty
    local -a flags

    flags=('--porcelain')
    hide_dirty="$(git config --get oh-my-zsh.hide-dirty)"

    if [[ $hide_dirty != "1" ]]; then
        if __zplug::base::base::git_version 1.7.2; then
            flags+=('--ignore-submodules=dirty')
        fi
        if [[ $DISABLE_UNTRACKED_FILES_DIRTY == true ]]; then
            flags+=('--untracked-files=no')
        fi
        _status="$(git status "$flags[@]" | tail -n 1)"
    fi

    if [[ -n $_status ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}

function __zplug::base::base::version_requirement() {
    local -i idx
    local -a min val

    [[ $1 == $2 ]] && return 0

    val=("${(s:.:)1}")
    min=("${(s:.:)2}")

    for (( idx=1; idx <= $#val; idx++ ))
    do
        if (( val[$idx] > ${min[$idx]:-0} )); then
            return 0
        elif (( val[$idx] < ${min[$idx]:-0} )); then
            return 1
        fi
    done

    return 1
}

function __zplug::base::base::git_version() {
    # Return false if git command doesn't exist
    if (( ! $+commands[git] )); then
        return 1
    fi

    __zplug::base::base::version_requirement \
        ${(M)${(z)"$(git --version)"}:#[0-9]*[0-9]} \
        "${@:?}"
    return $status
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
    local ref

    ref="$(git symbolic-ref --quiet HEAD 2>/dev/null)"
    local ret=$?

    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return 0 # no git repo
        ref=$(git rev-parse --short HEAD 2>/dev/null) || return 0
    fi
    echo "${ref#refs/heads/}"
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

    echo "%{${FG[004]}%}${dir}${zsh_prompt_divider}"
}
