DOTFILES=~/.dot

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export GOPATH=~/src/go

export EDITOR=vim
export VISUAL=vim

export PIP_REQUIRE_VIRTUALENV=false
export PIP_RESPECT_VIRTUALENV=true

export KEYTIMEOUT=1

# export CLOUD_ENVIRONMENT=true

export _Z_DATA=$HOME/.z.dat
export _Z_NO_RESOLVE_SYMLINKS=true
export _Z_OWNER=morr

export PATH=\
$HOME:\
/opt:\
/var:\
$HOME/bin:\
/usr/local/src:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/bin:\
/sbin:\
$GOPATH/bin

export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=false

source $DOTFILES/alias.env

for file in $DOTFILES/*.priv.env; do
    source $file
done
