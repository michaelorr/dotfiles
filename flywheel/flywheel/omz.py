import os

from git import Repo

from settings import flywheel

settings = flywheel.settings


if not os.path.lexists(settings.OMZ.PATH):
    Repo.clone_from(settings.OMZ.REPO, settings.OMZ.PATH)
# update the repo


for dir_name in settings.OMZ.CUSTOM_DIRS:
    dir_path = settings.OMZ.PATH + dir_name
    if not os.path.lexists(dir_path):
        os.mkdir(dir_path)


'''
ln -s -f ~/.dot/oh-my-zsh ~/.oh-my-zsh
ln -s -f ~/.dot/michaelorr.zsh.theme ~/.dot/oh-my-zsh/custom/themes/michaelorr.zsh-theme

# syntax highlighting
if [ ! -d ~/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.dot/oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
else
    echo "FIXME: update the repo" >&2
fi
'''

for dotfile in settings.OMZ.DOTFILES:
    source = "%s/%s" % (settings.DOTREPO.PATH, dotfile)
    destination = "%s/.%s" % (settings.HOME, dotfile)
    if not os.path.lexists(destination):
        os.symlink(source, destination)
