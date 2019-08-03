#!/usr/bin/env zsh

function _zsh_theme::prompt::git() {
    branch=$(git_current_branch)
    [[ -z $branch ]] && return 0
    echo "${ZSH_THEME_GIT_PROMPT_FORMAT}${branch}%{${FX[reset]}%}${zsh_prompt_divider}"
    # echo "$(parse_git_dirty)${branch}%{${FX[reset]}%}${zsh_prompt_divider}"
}

function _zsh_theme::prompt::prefix() {
    return_code="%{%(?.$FG[002].$FG[001])%}$zsh_prompt_prefix" # (?.$GREEN.$RED)
    echo ${VI_MODE:-$return_code}
}

function _zsh_theme::prompt::dir {
    dir="%~"
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = "true" ]]; then
        path_from_git_root=${$(git rev-parse --show-prefix)%/}
        [[ $path_from_git_root ]] && path_from_git_root="/$path_from_git_root"
        dir="$(_zsh_theme::prompt::git::repo)${path_from_git_root}"
    fi
    echo "${ZSH_THEME_DIR_PROMPT_FORMAT}${dir}${zsh_prompt_divider}"
}

function _zsh_theme::async::git_status() {
    typeset -g _ZSH_ASYNC_GIT_DIRTY_FD

    # reset the format before cmd is drawn
    export ZSH_THEME_GIT_PROMPT_FORMAT="$ZSH_THEME_GIT_PROMPT_CLEAN"

    # close existing file descriptor if it exists
    { exec {_ZSH_ASYNC_GIT_DIRTY_FD}<&- || true } 2>/dev/null

    # if we are in a git repo, run slow cmd via process substitution attached to our fd
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = "true" ]]; then
        exec {_ZSH_ASYNC_GIT_DIRTY_FD}< <(
            if [[ "$(command git config --get zsh-morr.large-repo)" ]]; then
                # In repos marked large, don't spool up threads instantly.
                # This eases some burdon on the underlying hardware.
                # TODO find a way to make this a singleton process
                sleep 0.15
            fi
            exec git status
        )
    fi

    # Set callback to our fd
    zle -F "$_ZSH_ASYNC_GIT_DIRTY_FD" _zsh_theme::async::git_status_callback
}

function _zsh_theme::async::git_status_callback() {
    # FD is only argument to this handler
    if [[ -n "$(<&$1)" ]]; then
        export ZSH_THEME_GIT_PROMPT_FORMAT="$ZSH_THEME_GIT_PROMPT_DIRTY"
        zle reset-prompt && zle -R # redraw prompt
    fi
    zle -F "$1" # remove callback handler from fd
    exec {1}<&- # close the fd
}
