#!/usr/bin/env zsh

fpath+=$DOT/zsh/funcs
autoload -Uz govim
[[ -f "${DOT}/zsh/funcs/ro_db" ]] && autoload -Uz ro_db
