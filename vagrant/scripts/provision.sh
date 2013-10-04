#!/bin/sh
set -e

# This script should contain custom configuration commands you want to
# run inside the guest each time you run `vagrant up`.

# This should be idempotent as Vagrant can re-provision the box without
# halting or suspending it.


### Step (1)
# apt-get any necessary packages

  # FIXME this only exists to overcome a bug datagrok left in his custom box; remove when fixed
  if [ ! -e /root/fixed-statoverride ]; then
    sudo sed -i -e '/puppet/d' /var/lib/dpkg/statoverride
    sudo touch /root/fixed-statoverride
  fi

if [ ! -e /root/packages-installed ]; then
    sudo apt-get update
    sudo apt-get install -y git ack-grep vim zsh ipython pylint man xclip
    sudo touch /root/packages-installed
fi

### Step (2)
# clone dotfiles repo
# clone oh-my-zsh repo
# clone zsh-syntax-highlighting repo, add to omz custom plugins
# 

# Clone or update dotfiles
if [ ! -d ~/.dot ]; then
    echo "Cloning dotfiles repo"
    cd ~
    git clone https://github.com/michaelorr/dotfiles.git .dot
else
    echo "FIXME: update the repo" >&2
fi

# Clone or update OMZ
if [ ! -d ~/.dot/oh-my-zsh ]; then
    echo "Cloning OMZ"
    cd ~/.dot
    git clone https://github.com/robbyrussell/oh-my-zsh.git
else
    echo "FIXME: update the repo" >&2
fi

# Create omz custom folders
if [ ! -d ~/.dot/oh-my-zsh/custom/plugins ]; then
    mkdir -p ~/.dot/oh-my-zsh/custom/plugins
fi
if [ ! -d ~/.dot/oh-my-zsh/custom/themes ]; then
    mkdir -p ~/.dot/oh-my-zsh/custom/themes
fi

# look for jellydoughnut, symlink zsh plugin into omz
if [ -d ~/mnt/jellydoughnut ]; then
    plugin_loc=~/mnt/jellydoughnut/lib/med/med.plugin.zsh
elif [ -d ~/srcjellydoughnut ]; then
    plugin_loc=~/src/jellydoughnut/lib/med/med.plugin.zsh
fi
if [ ! -z "$plugin_loc" ]; then
    if [ ! -d ~/.dot/oh-my-zsh/custom/plugins/med ]; then
        mkdir -p ~/.dot/oh-my-zsh/custom/plugins/med
        ln -s -f $plugin_loc ~/.dot/oh-my-zsh/custom/plugins/med/med.plugin.zsh
    fi
fi

# zsh-syntax-highlighting plugin for zsh
if [ ! -d ~/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.dot/oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
else
    echo "FIXME: update the repo" >&2
fi

### Step (3)
# symlink all the things

if [ ! -e /root/symlinks-created ]; then
    ln -s -f ~/.dot/michaelorr.zsh-theme ~/.dot/oh-my-zsh/custom/themes/michaelorr.zsh-theme
    ln -s -f ~/.dot/ackrc ~/.ackrc
    ln -s -f ~/.dot/oh-my-zsh ~/.oh-my-zsh
    ln -s -f ~/.dot/vim ~/.vim
    ln -s -f ~/.dot/vimrc ~/.vimrc
    ln -s -f ~/.dot/zprofile ~/.zprofile
    ln -s -f ~/.dot/zshenv ~/.zshenv
    ln -s -f ~/.dot/zshrc ~/.zshrc
    sudo touch /root/symlinks-created
fi



### Step (4)
# set shell to use zsh

sudo chsh -s $(which zsh) $USER

### Step (5)
# git configs

git config --global core.excludesfile '~/.dot/gitignore_global'
git config --global color.ui true
