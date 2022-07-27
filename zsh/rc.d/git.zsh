#!/usr/bin/env zsh

function _zsh_theme::prompt::git::repo() {
    # Echo the repo name if inside of one. This should be safe to run in
    # any context, including inside a .git directory or inside a repo but not
    # within the working tree
    local dotgitdir=$(git rev-parse --absolute-git-dir 2> /dev/null)

    if [[ $dotgitdir ]]; then
        echo $(dirname $dotgitdir | xargs basename)
    fi
}
