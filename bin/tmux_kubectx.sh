#!/bin/zsh
ctx=$(kubectx -c 2>/dev/null | cut -d'/' -f2)
[[ ! -z $ctx ]] && echo "#[fg=#57575e]│ #[fg=white,bg=#020221]$ctx"
