#! /usr/bin/env zsh

if [ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
    echo "Install zsh-autosuggestions [mo]"
fi
