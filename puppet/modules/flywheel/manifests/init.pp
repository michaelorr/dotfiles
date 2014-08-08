define flywheel::git_config(
  $value,
  $username,
  $section  = regsubst($name, '^([^\.]+)\.([^\.]+)$','\1'),
  $key      = regsubst($name, '^([^\.]+)\.([^\.]+)$','\2'),
) {
  exec{"git config --global ${section}.${key} '${value}'":
    #environment => inline_template('<%= "HOME=" + ENV["HOME"] %>'),
    user        => vagrant,
    path        => ['/usr/bin', '/bin'],
    unless      => "git config --global --get ${section}.${key} '${value}'",
  }
}


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


    exec{"/usr/bin/git config --global user.name 'Michael Orr'":
        environment => inline_template('<%= "HOME=" + ENV["HOME"] %>'),
        #user        => vagrant,
        #path        => ['/usr/bin', '/bin'],
        #unless      => "git config --global --get ${section}.${key} '${value}'",
    }

    #flywheel::git_config { 'user.name':
    #    value => 'Michael Orr',
    #    username => 'vagrant',
    #}

    #flywheel::git_config { 'user.email':
    #    value => 'michael@orr.co',
    #    username => 'vagrant',
    #}

    git::config { 'core.excludesfile':
        value => '~/.dot/gitignore_global',
    }

    git::config { 'color.ui':
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
