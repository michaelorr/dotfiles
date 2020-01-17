#!/usr/bin/env zsh

function _zsh_theme::prompt::git() {
    branch=$VCS_STATUS_LOCAL_BRANCH
    [[ -z $branch ]] && return 0
    echo "${ZSH_THEME_GIT_PROMPT_FORMAT}${branch}${zsh_prompt_divider}${ZSH_THEME_GIT_PROMPT_SUFFIX}%{${FX[reset]}%}${zsh_prompt_divider}"
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
    if [[ $GITSTATUS_ENABLED == true ]]; then
        gitstatus_query -d $PWD -c _zsh_theme::async::gitstatus_callback -t 0 GSD
    fi
}

function _zsh_theme::async::gitstatus_callback() {
    _zsh_theme::branch_styles "CLEAN"
    [[ $VCS_STATUS_HAS_UNSTAGED = 1 || $VCS_STATUS_HAS_UNTRACKED = 1 || $VCS_STATUS_HAS_UNTRACKED = 1 ]] && _zsh_theme::branch_styles "DIRTY"
    [[ $VCS_STATUS_HAS_CONFLICTED = 1 ]] && _zsh_theme::branch_styles "CONFLICTED"

    [[ $VCS_STATUS_HAS_UNTRACKED = 1 ]] && export GIT_UNTRACKED_ptr="${GIT_UNTRACKED}" || export GIT_UNTRACKED_ptr="$GIT_CIRCLE"
    [[ $VCS_STATUS_HAS_UNSTAGED = 1 ]] && export GIT_UNSTAGED_ptr="${GIT_UNSTAGED}" || export GIT_UNSTAGED_ptr="$GIT_CIRCLE"
    [[ $VCS_STATUS_HAS_STAGED = 1 ]] && export GIT_STAGED_ptr="${GIT_STAGED}" || export GIT_STAGED_ptr="$GIT_CIRCLE"
    _zsh_theme::refresh_git_suffix
    zle && zle reset-prompt
}

function _zsh_theme::refresh_git_suffix() {
    export ZSH_THEME_GIT_PROMPT_SUFFIX=" ${GIT_UNTRACKED_ptr}${GIT_UNSTAGED_ptr}${GIT_STAGED_ptr}"
}

function _zsh_theme::branch_styles() {
    local branch_style="ZSH_THEME_GIT_PROMPT_$1"
    export ZSH_THEME_GIT_PROMPT_FORMAT="${(P)branch_style}"
}

precmd_functions+=_zsh_theme::async::git_status
