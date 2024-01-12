# gitkit
#


# gcount - count lines added & removed in a diff

gcount() {
  ruby -e \
    '
      added = 0
      removed = 0
      str = ARGF.read
      str.split("\n").each do |l|
        if (/^\+{3}/.match(l) || /^-{3}/.match(l))
          ;
        elsif (/^\+[^+]*/.match(l))
          added += 1
        elsif (/^-[^-]*/.match(l))
          removed += 1
        end
      end
      if (added == 0 and removed == 0)
        puts "            Σ: 0"
      else
        diff = added - removed
        if (diff > 0)
          diffstr = "+" + diff.to_s
        else
          diffstr = diff.to_s
        end
        puts "    Lines added: " + added.to_s
        puts "  Lines removed: " + removed.to_s
        puts "              Σ: " + (added + removed).to_s
        puts "              ∂: " + diffstr.to_s
      end
    '
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


# GIT_EXCLUDE=(':!modules/*/dist/*' ':!modules/*/src/js/styleVar*' ':!build')
# gtlm() {
#   git diff $1 . ${GIT_EXCLUDE[*]}
# }
# alias gadm="git add -u . ${GIT_EXCLUDE[*]}; gts"
