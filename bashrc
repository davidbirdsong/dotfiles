set -o vi

source_files=(
  ~/.go_env
  ~/.mise.bashrc
  ~/.githhub_tokens
  ~/.gcloud
  ~/.aws_aliases
  ~/.brew_completions
)
for f in "${source_files[@]}"; do
  [[ -f $f ]] || continue
  . $f
done

# this doesn't seem to work
# . "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1

# echo >> /Users/david.birdsong/.zprofile
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/david.birdsong/.zprofile
# eval "$(/opt/homebrew/bin/brew shellenv)"
#
# Git branch helper
parse_git_branch() {
  command -v git >/dev/null 2>&1 || return
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local branch
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)

  if [[ -n $branch ]]; then
    printf "%s" "$branch"
  else
    printf "DETACHED"
  fi
}

# PS1
export PS1='\[\e[36m\]\w\[\e[0m\]$(git_branch=$(parse_git_branch); [ -n "$git_branch" ] && printf " \[\e[33m\](%s)\[\e[0m\]" "$git_branch") \$ '

alias vi=nvim
alias go-me="pushd ~/src/go/src/github.com/davidbirdsong/"

PATH="$HOME/bin:""$PATH"
PATH="/usr/local/bin:/usr/local/go/bin/:/opt/homebrew/bin:""$PATH"":$GOPATH/bin"
export PATH="$PATH"

# export CGO_LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix re2)/lib"
export CGO_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/re2/lib"

# export OPENSSL_ROOT_DIR="$(brew --prefix openssl)/lib"
export OPENSSL_ROOT_DIR="/opt/homebrew/opt/openssl@3/lib"
