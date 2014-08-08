node default {
    $user = "vagrant"
    $home = "/home/${::user}"
    $linux = true
    $osx = false

    include flywheel
}
