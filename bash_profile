if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Kubernetes
alias kid='export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/benchprep-integration-dallas/kube-config-dal10-benchprep-integration-dallas.yml'
alias kis='export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/benchprep-integration-sanjose/kube-config-sjc03-benchprep-integration-sanjose.yml'
alias ksd='export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/benchprep-staging-dallas/kube-config-dal10-benchprep-staging-dallas.yml'
alias kss='export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/benchprep-staging-sanjose/kube-config-sjc03-benchprep-staging-sanjose.yml'
alias pods='/usr/local/bin/kubetcl get pods'
alias secrets='/usr/local/bin/kubetcl get secrets'
alias k=/usr/local/bin/kubetcl
alias kd=/usr/local/bin/kubetcl describe
alias kg=/usr/local/bin/kubetcl get
alias ksys=/usr/local/bin/kubetcl --namespace=kube-system

export KUBECONFIG=$HOME/.bluemix/plugins/container-service/clusters/benchprep-integration-dallas/kube-config-dal10-benchprep-integration-dallas.yml

## `ksh benchprep-v2` open shell in application
function ksh() {
  pod=$(kubectl get pods | rg $1 | rg Running | head -n1 | cut -d' ' -f1)
  cmd=${2:-bash}
  echo "Executing [$cmd] in: [$pod]"
  kubectl exec $pod -it $cmd
}

export PROJECT_DIR="$HOME/projects/benchprep"
