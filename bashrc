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


alias vi=nvim
alias gs=git-spice
alias go-me="pushd ~/src/go/src/github.com/davidbirdsong/"

PATH="$HOME/bin:""$PATH"
PATH="/usr/local/bin:/usr/local/go/bin/:/opt/homebrew/bin:""$PATH"":$GOPATH/bin"
export PATH="$PATH"

# export CGO_LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix re2)/lib"
export CGO_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/re2/lib"

# export OPENSSL_ROOT_DIR="$(brew --prefix openssl)/lib"
export OPENSSL_ROOT_DIR="/opt/homebrew/opt/openssl@3/lib"
[[ -f ~/.mise.bashrc ]]  && . ~/.mise.bashrc

complete -C /opt/homebrew/bin/git-spice git-spice
complete -C /opt/homebrew/bin/git-spice gs
