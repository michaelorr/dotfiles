#!/usr/bin/env zsh

### Local
zplug "$DOT/zplug/vpn", from:local, as:command

### OMZ
zplug "plugins/tmux", from:oh-my-zsh

### Other
zplug "zsh-users/zsh-autosuggestions"
zplug 'jsahlen/tmux-vim-integration.plugin.zsh'
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # defer:2 loads this plugin after compinit

### Self
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
