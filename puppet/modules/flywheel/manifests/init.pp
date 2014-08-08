class flywheel {

    stage { 'init':} -> stage { 'pre':} -> Stage['main'] -> stage {'post':} -> stage {'final':}

    class {'packages':
        stage => 'init'
    }

    class {'clone_repos':
        stage => 'pre'
    }

    class {'omz_setup':
        stage => 'main'
    }

    class {'cmg_setup':
        stage => 'main'
    }

    class {'pindrop_setup':
        stage => 'main'
    }

    class {'dotfiles':
        stage => 'final'
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
    package { 'git': ensure => "latest" }

    exec { "apt-get update": command => "/usr/bin/sudo apt-get update"}
}

class clone_repos {

}

class omz_setup {

}

class cmg_setup {

}

class pindrop_setup {

}

class dotfiles {

}
