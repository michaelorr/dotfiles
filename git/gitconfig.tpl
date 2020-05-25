[user]
    name = Michael Orr
    email = michael.orr@mailchimp.com
[color]
    branch = auto
    diff = auto
    ui = auto
    interactive = true
    status = auto
[color "branch"]
    current = yellow
    local = 241
    remote = green
[color "diff"]
    meta = yellow
    frag = magenta
    old = red
    new = green
[color "status"]
    added = green
    changed = yellow
    untracked = magenta
[core]
    excludesfile = ${DOT}/git/ignore
    filemode = false
    autocrlf = false
    deltaBaseCacheLimit = 1G
    untrackedCache = true
[diff]
    renameLimit = 2000
[merge]
    conflictstyle = diff3
[github]
    user = morr
[hub]
    # used by https://github.com/tyru/open-browser-github.vim
    host = git.rsglab.com
[alias]
    purgeBranches = "!f() { git branch --merged ${1-master} | grep -v \" ${1-master}$\" | xargs -n 1 git branch -d; }; f"
    dif = diff
[init]
    templatedir = ${DOT}/git/templates
[credential "https://source.developers.google.com"]
    helper = gcloud.sh
$CREDENTIAL
