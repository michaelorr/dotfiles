#!/usr/bin/env zsh

# plugins+=git
# plugins+=git-extras
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
# git status -uno --porcelain app tests batch etc
# `git status` == `git status --short`

# - checkout prezto and omz git plugins
# - figure out where git prompt functions are coming from
##
# Vcs info
##
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git svn hg
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' formats "%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[blue]%}%b%{$reset_color%}] %{$fg[yellow]%}%s%{$reset_color%}:%r"
#precmd() {  # run before each prompt
#    vcs_info
#}
# https://www.reddit.com/r/zsh/comments/901b8b/faster_and_more_reliable_way_to_colorize_zsh_vcs/
# https://github.com/denysdovhan/spaceship-prompt/issues/307
# https://github.com/mafredri/zsh-async
# https://github.com/sindresorhus/pure (async)

# Return 0 if current working tree is clean
function _zsh::git::repo_clean() {
    if [[ -n $(git status --porcelain --ignore-submodules=dirty 2>/dev/null) ]]; then
        return 1
    fi
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
    local ref="$(git symbolic-ref --quiet HEAD 2>/dev/null)"
    local ret=$?

    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return 0 # no git repo
        ref=$(git rev-parse --short HEAD 2>/dev/null) || return 0
    fi
    echo "${ref#refs/heads/}"
}

function _zsh_theme::prompt::git::repo() {
    # Echo the repo name if inside of one. This should be safe to run in
    # any context, including inside a .git directory or inside a repo but not
    # within the working tree
    local dotgitdir=$(git rev-parse --absolute-git-dir 2> /dev/null)

    if [[ $dotgitdir ]]; then
        echo $(dirname $dotgitdir | xargs basename)
    fi
}
