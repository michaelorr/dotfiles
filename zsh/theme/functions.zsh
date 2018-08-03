#!/usr/bin/env zsh

function _zsh_theme::prompt::git() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "${ZSH_THEME_GIT_PROMPT_FORMAT}${branch}%{${FX[reset]}%}${zsh_prompt_divider}"
        # echo "$(parse_git_dirty)${branch}%{${FX[reset]}%}${zsh_prompt_divider}"
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

    echo "${ZSH_THEME_DIR_PROMPT_FORMAT}${dir}${zsh_prompt_divider}"
}

function _zsh_theme::async::git_status() {
    typeset -g _ZSH_ASYNC_GIT_DIRTY_FD

    # reset the format before cmd is drawn
    export ZSH_THEME_GIT_PROMPT_FORMAT="$ZSH_THEME_GIT_PROMPT_CLEAN"

    # close existing file descriptor if it exists
    if [[ -n "$_ZSH_ASYNC_GIT_DIRTY_FD" ]] && { true <&$_ZSH_ASYNC_GIT_DIRTY_FD } 2>/dev/null; then
        exec {_ZSH_ASYNC_GIT_DIRTY_FD}<&-
    fi

    # if we are in a git repo, run slow cmd via process substitution attached to our fd
    if [[ -n $(_zsh_theme::prompt::git::repo) ]]; then
        exec {_ZSH_ASYNC_GIT_DIRTY_FD}< <(
            if [[ "$(command git config --get zsh-morr.large-repo)" ]]; then
                # In repos marked large, don't spool up threads instantly.
                # This eases some burdon on the underlying hardware.
                sleep 0.15
            fi
            git status
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
