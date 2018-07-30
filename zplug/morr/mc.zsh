#!/usr/bin/env zsh

# Add all identities from keychain to ssh-agent
ssh-add -A &> /dev/null

# Plums
setopt cdable_vars
plums=$SRC/mailchimp/app/lib/Plums
fpath+=$DOT/zsh/funcs
autoload -U plums
