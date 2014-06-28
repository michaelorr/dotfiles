from collections import namedtuple

Flywheel = namedtuple('Flywheel', 'configured settings')
Settings = namedtuple('Settings', 'USER HOME SRC_PATH DOTREPO ZSH OMZ')
Dotrepo = namedtuple('Dotrepo', 'PATH REPO')
Zsh = namedtuple('Zsh', 'DOTFILES')
Omz = namedtuple('Omz', 'PATH REPO PLUGIN_PATH PLUGINS CUSTOM_DIRS DOTFILES')
Plugins = namedtuple('Plugins', 'SYNTAX_COLORS')
Plugin = namedtuple('Plugin', 'REPO')

user = 'morr'
home = '/home/' + user
src_path = home + '/src'
dot_path = src_path + '/.dot'
omz_path = dot_path + '/oh-my-zsh'

flywheel = Flywheel(
    configured=True,
    settings=Settings(
        USER=user,
        HOME=home,
        SRC_PATH=src_path,
        DOTREPO=Dotrepo(
            PATH=dot_path,
            REPO='https://github.com/michaelorr/dotfiles.git'
        ),
        ZSH=Zsh(
            DOTFILES=['zshrc', 'zshenv', 'zprofile']
        ),
        OMZ=Omz(
            PATH=omz_path,
            REPO='https://github.com/robbyrussel/oh-my-zsh.git',
            PLUGIN_PATH=omz_path + '/custom/plugins',
            PLUGINS=Plugins(
                SYNTAX_COLORS=Plugin(
                    REPO='https://github.com/zsh-users/zsh-syntax-highlighting.git'
                )
            ),
            CUSTOM_DIRS=['/custom/plugins', '/custom/themes'],
            DOTFILES=['oh-my-zsh']
        )
    )
)
