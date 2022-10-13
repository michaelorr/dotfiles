${TPL_HEADER}
[user]
    name = Michael Orr
    email = ${DEFAULT_EMAIL}
[fetch]
    prune = true
[push]
    default = current
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
    ${GIT_PAGER}
${GIT_DELTA}
[diff]
    renameLimit = 2000
    colorMoved = default
[checkout]
    guess = false
[commit]
    verbose = true
[merge]
    conflictstyle = zdiff3
[github]
    user = morr
[pull]
    ff = only
[hub]
    # used by https://github.com/tyru/open-browser-github.vim
[alias]
    purgeBranches = "!f() { \
        local branch=$(git branch --show-current); \
        [[ "$branch" == "master" || "$branch" == "main" ]] && \
            (git branch --merged | grep -v " ${branch}$" | xargs -n 1 git branch -d) || \
            (echo "Must be on \"master\" or \"main\" branch."); \
    }; f"
    done = "!f() { git checkout master && git branch -d @{-1} && git pull upstream master && git push origin master; }; f"
    dif = diff
[init]
    templatedir = ${DOT}/git/templates
    defaultBranch = main
[credential "https://source.developers.google.com"]
    helper = gcloud.sh
$CREDENTIAL

# vim: ft=gitconfig
