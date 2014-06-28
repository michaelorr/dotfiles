# clone or update OMZ

ln -s -f ~/.dot/oh-my-zsh ~/.oh-my-zsh

'''
if [ ! -d ~/.dot/oh-my-zsh ]; then
    echo "Cloning OMZ"
    cd ~/.dot
    git clone https://github.com/robbyrussel/oh-my-zsh.git
else
    echo "FIXME: update the repo" >&2
fi
'''

'''
# create omz custom folders
if [ ! -d ~/.dot/oh-my-zsh/custom/plugins ]; then
    mkdir -p ~/.dot/oh-my-zsh/custom/plugins
fi
if [ ! -d ~/.dot/oh-my-zsh/custom/themes ]; then
    mkdir -p ~/.dot/oh-my-zsh/custom/themes ];
fi
'''

