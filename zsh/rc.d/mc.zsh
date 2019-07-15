#!/usr/bin/env zsh

# Add all identities from keychain to ssh-agent
# ssh-add -A &> /dev/null

fpath+=$DOT/zsh/funcs
autoload -Uz plums
autoload -Uz md_ssh
