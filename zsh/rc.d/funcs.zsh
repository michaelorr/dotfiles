#!/usr/bin/env zsh

fpath+=$DOT/zsh/funcs
autoload -Uz vimag
autoload -Uz vimf
autoload -Uz v
autoload -Uz qq
autoload -Uz rmqq
autoload -Uz listening
[[ -f "${DOT}/zsh/funcs/ro_db" ]] && autoload -Uz ro_db
