import os 
import subprocess

from settings import flywheel

settings = flywheel.settings

for dotfile in settings.ZSH.DOTFILES:
    source = '%s/%s' % (settings.DOTREPO.PATH, dotfile)
    dest = '%s/.%s' % (settings.HOME, dotfile)

    if not os.path.lexists(dest):
        os.symlink(source, dest)

zsh_path = subprocess.check_output('which zsh', shell=True).strip()
subprocess.call(
    ["chsh", " -s %s " % (zsh_path,)],
    shell=True
)

# should this maybe go in omz.py?
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
