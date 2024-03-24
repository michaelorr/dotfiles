#!/bin/zsh
ctx=$(kubectx -c 2>/dev/null | cut -d'/' -f2)
[[ ! -z $ctx ]] && echo "│ $ctx"
