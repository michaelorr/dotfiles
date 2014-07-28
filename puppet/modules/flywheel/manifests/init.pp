class flywheel {

    stage { 'pre':} -> Stage['main'] -> stage {'post':}

    class {'packages':
        stage => 'pre'
    }

    class {'git_setup':
        stage => 'pre'
    }

    class {'clone_repos':
        stage => 'main'
    }

    class {'omz_setup':
        stage => 'main'
    }

    class {'cmg_setup':
        stage => 'main'
    }

    class {'dotfiles':
        stage => 'main'
    }
}


class packages {
    package { 'ack-grep': ensure => "latest" }
    package { 'vim': ensure => "latest", require  => Exec['apt-get update']}
    package { 'zsh': ensure => "latest" }
    package { 'ipython': ensure => "latest" }
    package { 'pylint': ensure => "latest", require  => Exec['apt-get update']}
    package { 'man-db': ensure => "latest" }
    package { 'xclip': ensure => "latest" }
    package { 'tree': ensure => "latest" }
    package { 'tmux': ensure => "latest" }
    package { 'traceroute': ensure => "latest" }

    exec { "apt-get update": command => "/usr/bin/sudo apt-get update"}
}

class git_setup {
    include git

    git::config { 'user.name':
        user => 'vagrant',
        value => 'Michael Orr',
    }

    git::config { 'user.email':
        user => 'vagrant',
        value => 'michael@orr.co',
    }

    git::config { 'core.excludesfile':
        user => 'vagrant',
        value => '~/.dot/gitignore_global',
    }

    git::config { 'color.ui':
        user => 'vagrant',
        value => 'true',
    }
}


class clone_repos {
}

class omz_setup {
}

class cmg_setup {
}

class dotfiles {
}
