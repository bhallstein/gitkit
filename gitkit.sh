# gitkit
#


# gcount - count lines added & removed in a diff

gcount() {
  local added=0
  local removed=0
  local diff=0
  local diffstr=""

  # Read standard input line by line
  while IFS= read -r line || [[ -n "$line" ]]; do
    case "$line" in
      +++*|---*)
        # Ignore diff header lines
        ;;
      +*)
        ((added++))
        ;;
      -*)
        ((removed++))
        ;;
    esac
  done

  # Print results
  if (( added == 0 && removed == 0 )); then
    echo "            Σ: 0"
  else
    diff=$(( added - removed ))

    if (( diff > 0 )); then
      diffstr="+$diff"
    else
      diffstr="$diff"
    fi

    printf "    Lines added: %d\n" "$added"
    printf "  Lines removed: %d\n" "$removed"
    printf "              Σ: %d\n" "$(( added + removed ))"
    printf "              ∂: %s\n" "$diffstr"
  fi
}


# clone

alias gc="git clone"
alias gcr="git clone --recurse-submodules"


# status

alias gts="git status"


# checkout

alias gch="git checkout"
alias gchr="git checkout --recurse-submodules"
alias gchi="gch integration"
alias gchm="gch master"


# diff

alias gtl="git diff"
alias gtc="gtl | gcount"
alias gtln="git diff --name-status"
alias gtlc="git diff --cached"


# gh - show diff for a given commit

function gh() {
  local COMMIT

  if [ $# -eq 0 ]; then COMMIT=HEAD   # show for HEAD if no commit given
  elif [ $# -eq 1 ]; then COMMIT=$1
  fi

  if [ -z "$COMMIT" ]; then echo "u wot m8"
  else git diff "$COMMIT^..$COMMIT"
  fi
}


# fetch & pull

alias gf="git fetch --all --prune"
alias gtp="git pull"
alias gtpr="git pull --recurse-submodules"


# add & commit

alias gad="git add -u .; gts"   # -u also adds deletes
alias gadn="git add -N .; gts"  # include new files
gcom() {
  git commit -m "$*"
}


# merge

alias gm="git merge --no-ff --no-commit"


# branch list

alias gb="git branch --all"


# branch deletion

alias gD="git branch -D"
gDmerged() {
  git branch -d $(git branch --list --all --merged | grep -v '^\*' | grep -v -E '\s*remotes' | tr -d '\n')
}
gDall() {
  git branch -d $(git branch --list --all --no-merged | grep -v -E '\s*remotes' | tr -d '\n')
}


# branch rename

alias gbm="git branch -m"


# train-tracks view

alias gtts="git log --oneline --graph --decorate --abbrev-commit --color"
alias gtt="gtts --all"


# pushing

alias gpoh="git push origin HEAD"
alias gpohu="git push -u origin HEAD"


# rebasing

alias gr="git rebase --onto"
alias gri="git rebase --interactive --onto"
alias grc="git rebase --continue"


# clean

alias gcl="git clean -fd"


# watch commands with viddy

alias wst="viddy --disable_auto_save -n 2 git -c color.status=always status"
alias wdf="viddy --disable_auto_save -n 2 git diff --color=always"

# GIT_EXCLUDE=(':!modules/*/dist/*' ':!modules/*/src/js/styleVar*' ':!build')
# gtlm() {
#   git diff $1 . ${GIT_EXCLUDE[*]}
# }
# alias gadm="git add -u . ${GIT_EXCLUDE[*]}; gts"
