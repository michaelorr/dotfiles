#!/usr/bin/env zsh

fpath+=$DOT/zsh/funcs
autoload -Uz vimag
autoload -Uz vimf
autoload -Uz qq
autoload -Uz rmqq
[[ -f "${DOT}/zsh/funcs/ro_db" ]] && autoload -Uz ro_db
