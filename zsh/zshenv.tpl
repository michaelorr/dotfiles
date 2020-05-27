${TPL_HEADER}
# zsh/zshenv.tpl

LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

export DOT=${DOT}
export XDG_CONFIG_HOME=${HOME}/.config
export TOOLS=${TOOLS}
export SRC=${SRC}

export EDITOR=vim
export VISUAL=vim

cdpath=($SRC)

path+=$DOT/bin

## Below is the contents of zsh/env.d/*.env
