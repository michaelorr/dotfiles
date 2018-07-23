#!/usr/bin/env zsh

### Local
zplug "$DOT/zplug/base", from:local
zplug "$DOT/zplug/history", from:local
zplug "$DOT/zplug/mc", from:local
zplug "$DOT/zplug/aliases", from:local
zplug "$DOT/zplug/gcloud", from:local
zplug "$DOT/zplug/plums", from:local
zplug "$DOT/zplug/keybindings", from:local, defer:3 # Load keybindings last so they don't get reset

# >>> >>> >>>
zplug "$DOT/zplug/completions", from:local
zplug "$DOT/zplug/vi-mode", from:local
zplug "$DOT/zplug/git", from:local
# <<< <<< <<<

### OMZ
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh


### Other
zplug "zsh-users/zsh-autosuggestions"
zplug 'jsahlen/tmux-vim-integration.plugin.zsh'
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # defer:2 loads this plugin after compinit


### Self
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
