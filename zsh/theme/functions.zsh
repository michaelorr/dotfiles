#!/usr/bin/env zsh

function _zsh_theme::prompt::git() {
        branch=$(git_current_branch)
        [[ -z $branch ]] && return 0
        echo "$(parse_git_dirty)${branch}${FX[reset]}${zsh_prompt_divider}"
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

    echo "${FG[004]}${dir}${zsh_prompt_divider}" # blue
}
