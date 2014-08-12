class flywheel {
    $user = "vagrant"
    $home = "/home/${flywheel::user}"
    $linux = true
    $osx = false

    stage{'init':} -> stage{'pre':} -> Stage['main'] -> stage{'post':}

    class {'packages': stage => 'init'}
    class {'clone_repos': stage => 'pre'}
    class {'pindrop_setup': stage => 'main'}
    class {'dotfiles': stage => 'post'}
}

class packages {
    if $flywheel::linux {
        package { 'ack-grep': ensure => "latest" }
        package { 'xclip': ensure => "latest" }
        package { 'man-db': ensure => "latest" }
        package { 'vim-puppet': ensure => "latest" }

        package { 'vim': ensure => "latest", require  => Exec['apt-get update']}
        package { 'pylint': ensure => "latest", require  => Exec['apt-get update']}

        exec { "apt-get update": command => "/usr/bin/sudo apt-get update"}
    }

    if $flywheel::osx {
        # install homebrew first
        #package { 'vim': ensure => "latest", require  => Exec['brew update']}
        #package { 'pylint': ensure => "latest", require  => Exec['brew update']}
        # vim-puppet?
        #exec { "brew update": command => "/usr/bin/sudo brew update"}
    }

    package { 'zsh': ensure => "latest", before => Exec['chsh zsh']}
    package { 'ipython': ensure => "latest" }
    package { 'tree': ensure => "latest" }
    package { 'tmux': ensure => "latest" }
    package { 'traceroute': ensure => "latest" }
    package { 'git': ensure => "latest" }

    exec { "chsh zsh":
        command => "/usr/bin/sudo chsh -s $(which zsh) vagrant",    
        # TODO: Check for zsh
        # unless => "grep root /usr/lib/cron/cron.allow 2>/dev/null"
    }
}

class clone_repos {
    vcsrepo { "${flywheel::home}/.dot":
      ensure   => latest,
      provider => git,
      source   => "https://github.com/michaelorr/dotfiles.git",
      user     => "${flywheel::user}"
    }

    vcsrepo { "${flywheel::home}/.dot/oh-my-zsh":
      ensure   => present,
      provider => git,
      source   => "https://github.com/robbyrussell/oh-my-zsh.git",
      user     => "${flywheel::user}",
      require  => Vcsrepo ["${flywheel::home}/.dot"]
    }

    vcsrepo { "${flywheel::home}/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting":
      ensure   => present,
      provider => git,
      source   => "https://github.com/zsh-users/zsh-syntax-highlighting.git",
      user     => "${flywheel::user}",
      require  => Vcsrepo ["${flywheel::home}/.dot/oh-my-zsh"]
    }
}

class pindrop_setup {

}

class dotfiles {

    if $flywheel::linux {
        # colors and fonts
    }

    if $flywheel::osx {
        # colors and fonts
    }

    File {
        owner => $flywheel::user
    }


    file { "${flywheel::home}/.dot/oh-my-zsh/custom/themes":
        ensure => 'directory',
    }

    file { "${flywheel::home}/.dot/oh-my-zsh/custom/themes/michaelorr.zsh-theme":
       ensure  => 'link',
       target  => "${flywheel::home}/.dot/michaelorr.zsh-theme",
       require => File ["${flywheel::home}/.dot/oh-my-zsh/custom/themes"]
    }

    file { "rename original highlighter":
        path    => "${flywheel::home}/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh.orig",
        ensure  => 'present',
        source  => "${flywheel::home}/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh",
        replace => false,
    } -> file { "force symlink into place":
        path   => "${flywheel::home}/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh",
        ensure => 'link',
        target => "${flywheel::home}/.dot/main-highlighter.zsh",
        force  => true,
    }

    file { "${flywheel::home}/.ackrc":
       ensure => 'link',
       target => "${flywheel::home}/.dot/ackrc",
    }

    file { "${flywheel::home}/.oh-my-zsh":
       ensure => 'link',
       target => "${flywheel::home}/.dot/oh-my-zsh",
    }

    file { "${flywheel::home}/.vim":
       ensure => 'link',
       target => "${flywheel::home}/.dot/vim",
    }

    file { "${flywheel::home}/.vimrc":
       ensure => 'link',
       target => "${flywheel::home}/.dot/vimrc",
    }

    file { "${flywheel::home}/.zprofile":
       ensure => 'link',
       target => "${flywheel::home}/.dot/zprofile",
    }

    file { "${flywheel::home}/.zshenv":
       ensure => 'link',
       target => "${flywheel::home}/.dot/zshenv",
    }

    file { "${flywheel::home}/.zshrc":
       ensure => 'link',
       target => "${flywheel::home}/.dot/zshrc",
    }

    file { "${flywheel::home}/.gitconfig":
       ensure => 'link',
       target => "${flywheel::home}/.dot/gitconfig",
    }

    file { "${flywheel::home}/.tmux.conf":
       ensure => 'link',
       target => "${flywheel::home}/.dot/tmux.conf",
    }

    file { "${flywheel::home}/.vim/plugin/puppet.vim":
        ensure => 'link',
        target => '/usr/share/vim/addons/syntax/puppet.vim',
    }
}




########
#
# TODO
#
# modify sudoers
#
# .dot/oh-my-zsh/lib/git.zsh add a space to the beginning of the prompt
# add check to chsh
