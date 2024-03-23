#!/usr/bin/env zsh

# !23           # Re-execute history command 23
# !!            # The last command.
# !$            # Last word of the last command.
# !-2           # The last but one command.
# !-2$          # The last word of the command before the last command.
# !#$           # The last word of the current command line.
# !#0           # The first word of the current command line.
# !?foo         # The last command that matches the pattern `foo'.
# !?foo?1       # The second word of the last command line that matches `foo'.

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
HISTSIZE=10000000
SAVEHIST=10000000
