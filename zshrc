# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

alias ll='exa --long --all --git --header'
alias ct='ctags --exclude=node_modules --exclude=vendor -R'
alias certs='docker run -v /tmp/certs:/certs -e SSL_SUBJECT=comptia.benchprep.localhost   paulczar/omgwtfssl'

alias fixpg="rm /usr/local/var/postgres/postmaster.pid"
alias migrate_structure="psql -c 'drop database if exists wmx_rails_api_migrations' && psql -c 'create database wmx_rails_api_migrations;' && psql wmx_rails_api_migrations < db/structure.sql; DATABASE_NAME=wmx_rails_api_migrations be rake db:migrate"

export EDITOR="vim"
export PAGER="less -S"

# fasd initialization for faster loading
cache_file="${HOME}/.fasd-cache-zsh"
if [[ "${commands[fasd]}" -nt "$cache_file" || ! -s "$cache_file" ]]; then
  # Set the base init arguments.
  init_args=(posix-alias zsh-hook)

  # Set fasd completion init arguments
  init_args+=(zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)

  # Cache init code.
  fasd --init "$init_args[@]" >! "$cache_file" 2> /dev/null
fi
source "$cache_file"
unset cache_file init_args

# source powerlevel10k theme
source $HOME/personal/powerlevel10k/powerlevel10k.zsh-theme

export PROJECT_DIR="$HOME/projects"
alias pd='cd $PROJECT_DIR'

export DATABASE_USER=$USER
export REPORTING_DATABASE_USER=johngill
export PAGER="less -S"

## Kubernetes section
alias pods='/usr/local/bin/kubectl get pods'
alias secrets='/usr/local/bin/kubectl get secrets'
alias k=/usr/local/bin/kubectl
alias kd='/usr/local/bin/kubectl describe'
alias kg='/usr/local/bin/kubectl get'
alias ksys=/usr/local/bin/kubectl --namespace=kube-system

### `ksh benchprep-v2` open shell in application
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
## End of kubernetes section



eval "$(rbenv init -)"

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%3~%f%b %# '
export PATH="/usr/local/sbin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
