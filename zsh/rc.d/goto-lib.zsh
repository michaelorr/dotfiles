#!/usr/bin/env zsh

# Fully encapsulated goto feature: autoload, helpers, and zle widget.
# Included by bootstrap only when enable_goto=true.

autoload -Uz g

_goto_completion() {
  local project key display nick aname repo repo_path
  local -a projects repos

  if (( CURRENT == 2 )); then
    for key in ${(ok)GOTO_PROJECTS}; do
      display=${GOTO_PROJECTS[$key]}
      projects+=("${key}:${display//:/\\:}")
    done

    for nick in ${(ok)GOTO_NICKS}; do
      project=${GOTO_NICKS[$nick]}
      display=${GOTO_PROJECTS[$project]}
      projects+=("${nick}:${display//:/\\:} (${project})")
    done

    _describe -t projects 'project' projects
    return
  fi

  if (( CURRENT == 3 )); then
    project=$(_goto_resolve_project "${words[2]}") || return 1
    aname=${GOTO_REPOS[$project]}
    [[ -n $aname ]] || return 1

    for repo in ${(Pok)aname}; do
      repo_path=${(P)${:-${aname}[$repo]}}
      repos+=("${repo}:${repo_path//:/\\:}")
    done

    _describe -t repos 'repo' repos
  fi
}
compdef _goto_completion g

_goto_fzf() {
  local header=$1
  shift
  fzf \
    --header="$header" \
    --reverse \
    --height=40% \
    --border \
    --cycle \
    --delimiter=$'\t' \
    "$@"
}

# Input: None
# Behavior: Using fzf, allow user to select a project
# FZF Columns: name, nick, key (key hidden; search prefers nick then name).
# Return: Project Key
_goto_pick_project() {
  local key display nick n choice
  local -a entries

  for key in ${(ok)GOTO_PROJECTS}; do
    display=${GOTO_PROJECTS[$key]}
    nick=
    for n in ${(k)GOTO_NICKS}; do
      [[ ${GOTO_NICKS[$n]} == "$key" ]] && { nick=$n; break }
    done
    entries+=("${display}"$'\t'"${nick}"$'\t'"${key}")
  done

  if (( ${#entries} == 0 )); then
    print -u2 "No projects configured in goto.env"
    return 1
  fi

  choice=$(printf '%s\n' "${entries[@]}" | _goto_fzf "Project" \
    --with-nth=1,2 \
    --nth=2,1)
  [[ -n $choice ]] || return 1
  print -r -- "${choice##*$'\t'}"
}

# Input: Project Key
# Return: The name of the assoc array that contains repos for the project
_goto_repos_array_name() {
  local project=$1
  local aname=${GOTO_REPOS[$project]}
  if [[ -z $aname ]]; then
    print -u2 "No repos configured for project: $project"
    return 1
  fi
  print -r -- "$aname"
}

# Input: project key, repo key
# Return: destination path, or fail
_goto_repo_path() {
  local project=$1 repo=$2
  local aname dest
  aname=$(_goto_repos_array_name "$project") || return 1
  dest=${(P)${:-${aname}[$repo]}}
  if [[ -z $dest ]]; then
    print -u2 "Unknown repo: $repo for project $project"
    return 1
  fi
  print -r -- "$dest"
}

# Input: Project Key
# Behavior: Using fzf, allow user to select a repo for that project.
#           Skips fzf and returns directly if the project has only one repo.
# FZF Columns: repo name, path (path hidden)
# Return: destination path
_goto_pick_repo() {
  local project=$1
  local aname repo repo_path choice
  local -a entries

  aname=$(_goto_repos_array_name "$project") || return 1

  for repo in ${(Pok)aname}; do
    repo_path=${(P)${:-${aname}[$repo]}}
    entries+=("${repo}"$'\t'"${repo_path}")
  done

  if (( ${#entries} == 0 )); then
    print -u2 "No repos configured for project: $project"
    return 1
  fi

  if (( ${#entries} == 1 )); then
    print -r -- "${entries[1]##*$'\t'}"
    return 0
  fi

  choice=$(printf '%s\n' "${entries[@]}" | _goto_fzf "Repo" --with-nth=1)
  [[ -n $choice ]] || return 1
  print -r -- "${choice##*$'\t'}"
}

# Input: project key or nickname
# Return: canonical project key, or fail
_goto_resolve_project() {
  local query=$1
  if (( ${+GOTO_PROJECTS[$query]} )); then
    print -r -- "$query"
    return 0
  fi
  if (( ${+GOTO_NICKS[$query]} )); then
    print -r -- "${GOTO_NICKS[$query]}"
    return 0
  fi
  print -u2 "Unknown project: $query"
  return 1
}

# Input: destination path
# Behavior: cd there, or fail if missing
_goto_cd() {
  local dest=$1
  if [[ ! -d $dest ]]; then
    print -u2 "Not a directory: $dest"
    return 1
  fi
  builtin cd -- "$dest"
}

# [ctrl+g]: project/repo navigation
goto-widget() {
  local orig_buffer=$BUFFER orig_cursor=$CURSOR

  zle -I

  g
  BUFFER=$orig_buffer
  CURSOR=$orig_cursor

  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N goto-widget
bindkey -M viins '^G' goto-widget
bindkey -M vicmd '^G' goto-widget

# vim: ft=zsh:
