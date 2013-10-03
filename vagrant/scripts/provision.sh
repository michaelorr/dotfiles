#!/bin/sh
set -e

# This script should contain custom configuration commands you want to
# run inside the guest each time you run `vagrant up`.

# This should be idempotent as Vagrant can re-provision the box without
# halting or suspending it.


### Step (1)
# clone dotfiles repo
# clone oh-my-zsh repo
# clone zsh-syntax-highlighting repo

if [ ! -d ~/.dot ]; then
    echo "Cloning dotfiles repo"
    cd ~
    git clone https://github.com/michaelorr/dotfiles.git .dot
fi

if [ ! -d ~/.dot/oh-my-zsh ]; then
    echo "Cloning OMZ"
    cd ~/.dot
    git clone https://github.com/robbyrussell/oh-my-zsh.git
fi

if [ ! -d ~/.dot/oh-my-zsh/custom/plugins ]; then
    echo "Cloning zsh syntax highlighting"
    cd ~/.dot/oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi


### Step (2)
# create symlinks for all of the above into the appropriate place

ln -s -f ~/.dot/ackrc ~/.ackrc
ln -s -f ~/.dot/oh-my-zsh ~/.oh-my-zsh
ln -s -f ~/.dot/vim ~/.vim
ln -s -f ~/.dot/vimrc ~/.vimrc
ln -s -f ~/.dot/zprofile ~/.zprofile
ln -s -f ~/.dot/zshenv ~/.zshenv
ln -s -f ~/.dot/zshrc ~/.zshrc

### Step (3)
# apt-get any necessary packages

sudo apt-get install -y man ack-grep vim zsh ipython man pylint


### Step (4)
# set shell to use zsh

sudo chsh -s $(which zsh) $USER

### Step (5)
# git configs
# misc

git config --global core.excludesfile '~/.dot/gitignore_global'
git config --global color.ui true
