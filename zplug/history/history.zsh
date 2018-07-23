#!/usr/bin/env zsh

setopt append_history # Don't overwrite, append!
setopt hist_expire_dups_first # Expire duplicate entries first when trimming history.
setopt hist_fcntl_lock # use OS file locking
setopt hist_ignore_all_dups # Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_space # Don't record an entry starting with a space.
setopt hist_lex_words # better word splitting, but more CPU heavy
setopt hist_no_store # Don't store `history` in the history file
setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
setopt hist_save_no_dups # Don't write duplicate entries in the history file.
setopt hist_verify # Perform history expansion without directly executing.
setopt inc_append_history # Write after each command
setopt share_history # share history between multiple shells

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
