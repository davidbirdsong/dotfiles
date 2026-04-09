set -o vi

source_files=(
  ~/.go_env
  ~/.githhub_tokens
  ~/.gcloud
  ~/.aws_aliases
  ~/.brew_completions
  ~/.kube_switcher
  ~/.git_ps1.rc
  ~/.git_spice_ps1.rc
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
#
PATH="$HOME""/bin:/opt/homebrew/bin:""$PATH"
PATH="/usr/local/bin:/usr/local/go/bin/""$PATH"
export PATH="$PATH"

alias gs=git-spice
alias go-me="pushd ~/src/go/src/github.com/davidbirdsong/"

# prefer mise-informed binary versions
if command -v mise >/dev/null 2>&1; then
  echo doing mise defs
  alias biome-fix="mise exec -- biome check --write ."

  vi() {
    mise exec -- nvim "$@"
  }

  go() {
    mise exec -- go "$@"
  }

  make() {
    mise exec -- make "$@"
  }

else
  alias vi=nvim

fi

# dont remember why these are here
# export CGO_LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix re2)/lib"
# export CGO_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/re2/lib"

# export OPENSSL_ROOT_DIR="$(brew --prefix openssl)/lib"
# export OPENSSL_ROOT_DIR="/opt/homebrew/opt/openssl@3/lib"

complete -C /opt/homebrew/bin/git-spice git-spice
complete -C /opt/homebrew/bin/git-spice gs

# improve history
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'
# need brew install fzf
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
  [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.bash" ] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.bash"
  [ -f "$(brew --prefix)/opt/fzf/shell/completion.bash" ] && source "$(brew --prefix)/opt/fzf/shell/completion.bash"
fi
