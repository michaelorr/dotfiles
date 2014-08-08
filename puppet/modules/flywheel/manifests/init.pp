class flywheel {
    stage{'init':} -> stage{'pre':} -> Stage['main'] -> stage{'post':}

    class {'packages': stage => 'init'}
    class {'clone_repos': stage => 'pre'}
    class {'pindrop_setup': stage => 'main'}
    class {'dotfiles': stage => 'post'}


    #notify { 'resource title':
    #  name     => # (namevar) An arbitrary tag for your own reference; the...
    #  message  => # The message to be sent to the...
    #  withpath => # Whether to show the full object path. Defaults...
      # ...plus any applicable metaparameters.
    #}
}

class packages {
    if $::linux {
        package { 'ack-grep': ensure => "latest" }
        package { 'xclip': ensure => "latest" }
        package { 'man-db': ensure => "latest" }

        package { 'vim': ensure => "latest", require  => Exec['apt-get update']}
        package { 'pylint': ensure => "latest", require  => Exec['apt-get update']}
        exec { "apt-get update": command => "/usr/bin/sudo apt-get update"}
    }

    if $::osx {
        # install homebrew first
        #package { 'vim': ensure => "latest", require  => Exec['brew update']}
        #package { 'pylint': ensure => "latest", require  => Exec['brew update']}
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
    vcsrepo { "${::home}/.dot":
      ensure   => latest,
      provider => git,
      source   => "https://github.com/michaelorr/dotfiles.git",
      user     => "${::user}"
    }

    vcsrepo { "${::home}/.dot/oh-my-zsh":
      ensure   => present,
      provider => git,
      source   => "https://github.com/robbyrussell/oh-my-zsh.git",
      user     => "${::user}",
      require  => Vcsrepo ["${::home}/.dot"]
    }

    vcsrepo { "${::home}/.dot/oh-my-zsh/custom/plugins/zsh-syntax-highlighting":
      ensure   => present,
      provider => git,
      source   => "https://github.com/zsh-users/zsh-syntax-highlighting.git",
      user     => "${::user}",
      require  => Vcsrepo ["${::home}/.dot/oh-my-zsh"]
    }
}

class pindrop_setup {

}

class dotfiles {

    if $::linux {
        # colors and fonts
    }

    if $::osx {
        # colors and fonts
    }


    file { "${::home}/.dot/oh-my-zsh/custom/themes":
        ensure => 'directory'
    }

    file { "${::home}/.dot/oh-my-zsh/custom/themes/michaelorr.zsh-theme":
       ensure  => 'link',
       target  => "${::home}/.dot/michaelorr.zsh-theme",
       require => File ["${::home}/.dot/oh-my-zsh/custom/themes"]
    }

    file { "${::home}/.ackrc":
       ensure => 'link',
       target => "${::home}/.dot/ackrc",
    }

    file { "${::home}/.oh-my-zsh":
       ensure => 'link',
       target => "${::home}/.dot/oh-my-zsh",
    }

    file { "${::home}/.vim":
       ensure => 'link',
       target => "${::home}/.dot/vim",
    }

    file { "${::home}/.vimrc":
       ensure => 'link',
       target => "${::home}/.dot/vimrc",
    }

    file { "${::home}/.zprofile":
       ensure => 'link',
       target => "${::home}/.dot/zprofile",
    }

    file { "${::home}/.zshenv":
       ensure => 'link',
       target => "${::home}/.dot/zshenv",
    }

    file { "${::home}/.zshrc":
       ensure => 'link',
       target => "${::home}/.dot/zshrc",
    }

    file { "${::home}/.gitconfig":
       ensure => 'link',
       target => "${::home}/.dot/gitconfig",
    }

    file { "${::home}/.tmux.conf":
       ensure => 'link',
       target => "${::home}/.dot/tmux.conf",
    }
}




########
#
# TODO
#
# modify sudoers
# sudo apt-get install vim-puppet
# ln -s /usr/share/vim/addons/syntax/puppet.vim ~/.vim/plugin/
#
# update prompt spacing and stuff

