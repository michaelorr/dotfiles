# This will install various needed python and OS packages


# install necessary packages:

'''
if [ ! -e /root/packages-installed ]; then
    sudo apt-get update
    sudo apt-get install -y git ack-grep vim zsh ipython pylint man xclip tree traceroute tmux
    sudo touch /root/packages-installed
fi
'''

# symlink package configs in place

ln -s -f ~/.dot/ackrc ~/.ackrc
ln -s -f ~/.dot/tmux.conf ~/.tmux.conf
