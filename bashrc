set -o vi

source_file=(
~/.go_env
~/.githhub_tokens
~/.gcloud 
~/.aws_aliases
~/.brew_completions
  )
for f in $source_files; do
  [[ -f $f ]] && . $f
done


# this doesn't seem to work
# . "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1

# echo >> /Users/david.birdsong/.zprofile
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/david.birdsong/.zprofile
# eval "$(/opt/homebrew/bin/brew shellenv)"
#
alias vi=/usr/local/bin/nvim
alias go-netlify="pushd ~/src/go/src/github.com/netlify/"
alias vgo-netlify="pushd ~/src/github.com/netlify/"
alias go-me="pushd ~/src/go/src/github.com/davidbirdsong/"

export PATH=/usr/local/bin:/usr/local/go/bin/:$PATH:$GOPATH/bin:/opt/homebrew/bin
export PATH="$PATH":"/opt/homebrew/opt/mysql-client/bin/"

# export CGO_LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix re2)/lib"
export CGO_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/re2/lib"

# export OPENSSL_ROOT_DIR="$(brew --prefix openssl)/lib"
export OPENSSL_ROOT_DIR="/opt/homebrew/opt/openssl@3/lib"
