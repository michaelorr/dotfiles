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
