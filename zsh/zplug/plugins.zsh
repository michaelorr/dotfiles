#!/usr/bin/env zsh

### Other
zplug "zsh-users/zsh-autosuggestions"
zplug 'jsahlen/tmux-vim-integration.plugin.zsh'
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # defer:2 loads this plugin after compinit
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
