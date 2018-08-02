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
