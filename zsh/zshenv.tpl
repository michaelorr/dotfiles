LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

TOOLS=${TOOLS}
CODE=${CODE}
DOT=${DOT}
SRC=${SRC}

EDITOR=vim
VISUAL=vim

cdpath=($SRC)

path+=$DOT/bin

for envfile in ${DOT}/zsh/env.d/*.env; do
    source ${envfile}
done

[[ -n $GOPATH ]] && path+=$GOPATH/bin
