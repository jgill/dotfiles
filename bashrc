alias be='bundle exec'

alias ga='git add -p'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gfp='git fetch --all --prune'

alias kraken="open -na 'GitKraken' --args -p $(pwd)"
alias ll='exa --long --all --git --header'
alias ct='ctags --exclude=node_modules --exclude=vendor -R'

alias certs='docker run -v /tmp/certs:/certs -e SSL_SUBJECT=comptia.benchprep.localhost   paulczar/omgwtfssl'
alias pd='cd $PROJECT_DIR'
alias dbs='cat $PROJECT_DIR/database-servers.md'
alias pdb_tunnel='ssh -N -L 8532:10.176.247.2:5432 deploy@169.63.216.219'
alias pdb='psql -h localhost -p 8532 -U wmxdbuser wmx_rails_api_production'
alias pxdb_tunnel='ssh -N -L 9532:10.161.109.215:5432 deploy@169.63.216.219'
alias pxdb='psql -h localhost -p 9532 -U wmxdbuser wmx_rails_api_production'
alias sdb_tunnel='ssh -N -L 7432:10.176.230.78:5434 deploy@169.63.216.219'
alias sdb='psql -h localhost -p 7432 -U wmxdbuser wmx_rails_api_staging'
alias idb_tunnel='ssh -N -L 6432:10.176.230.78:5433 deploy@169.63.216.219'
alias idb='psql -h localhost -p 6432 -U wmxdbuser wmx_rails_api_integration'
alias fixpg="rm /usr/local/var/postgres/postmaster.pid"
alias migrate_structure="psql -c 'drop database if exists wmx_rails_api_migrations' && psql -c 'create database wmx_rails_api_migrations;' && psql wmx_rails_api_migrations < db/structure.sql; DATABASE_NAME=wmx_rails_api_migrations be rake db:migrate"

export EDITOR="vim"
export PAGER="less -S"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"
source /usr/local/bin/tmuxinator.bash
source /usr/local/bin/git-completion.bash

fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

## Kubernetes
function kx() {
    export KUBE_CONTEXT=$1
    case $1 in
        integration-dallas)  export $KUBE_INTEGRATION_DALLAS;;
        integration-sanjose) export $KUBE_INTEGRATION_SANJOSE;;
        staging-dallas)      export $KUBE_STAGING_DALLAS;;
        staging-sanjose)     export $KUBE_STAGING_SANJOSE;;
        production-dallas)   export $KUBE_PRODUCTION_DALLAS;;
        production-sanjose)  export $KUBE_PRODUCTION_SANJOSE;;
        locust)              export $KUBE_LOCUST;;
    esac
}

function _kx() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W """ integration-dallas integration-sanjose staging-dallas staging-sanjose locust production-dallas production-sanjose """ -- $cur) )
}
complete -F _kx kx

function nbr () {
  jira="$1"
  title="${@:2}"
  slug="$(echo -n "$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z)"
  git checkout release_candidate
  git pull origin release_candidate
  git checkout -b "$jira-$slug"
}

alias pods='/usr/local/bin/kubectl get pods'
alias secrets='/usr/local/bin/kubectl get secrets'
alias k=/usr/local/bin/kubectl
alias kd='/usr/local/bin/kubectl describe'
alias kg='/usr/local/bin/kubectl get'
alias ksys=/usr/local/bin/kubectl --namespace=kube-system

## Passenger
alias ttr='passenger-config restart-app .'

## `ksh benchprep-v2` open shell in application
function ksh() {
  pod=$(kubectl get pods | rg $1 | rg Running | head -n1 | cut -d' ' -f1)
  cmd=${2:-bash}
  echo "Executing [$cmd] in: [$pod]"
  kubectl exec $pod -it $cmd
}

function albps() {
    pods="$(kubectl get pods | grep nginx-ingress | cut -d' ' -f1)"
    for pod in $pods; do
        echo $pod
        procs="$(kubectl exec -it -c nginx-ingress $pod -- ps afx | grep nginx)"
        printf '  shutting down: '
        echo "$procs" | grep 'shutting down' | wc -l
        printf '        defunct: '
        echo "$procs" | grep defunct | wc -l
    done
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
