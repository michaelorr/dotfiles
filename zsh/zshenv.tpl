LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

export DOT=${DOT}
TOOLS=${TOOLS}
SRC=${SRC}

EDITOR=vim
VISUAL=vim

cdpath=($SRC)

path+=$DOT/bin

for envfile in ${DOT}/zsh/env.d/*.env; do
    source ${envfile}
done
