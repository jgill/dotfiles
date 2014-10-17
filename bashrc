alias be='bundle exec'
alias sphinxql='mysql -P9306 --protocol=tcp --prompt="sphinxQL> "'

alias ec2_servers='cd /Users/johngill/projects/myhealthandmoney/devops && bundle exec ruby list_servers.rb'

alias ga='git add'
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

alias ll='ls -al'

export EDITOR="vim"
PS1="[\u@$(scutil --get ComputerName) \W]\\$ "

# amazon ec2 api tools

export PATH="/usr/local/bin:/usr/local/sbin:/Users/johngill/.rbenv/bin:/Users/johngill/.cabal/bin:$PATH"

source /usr/local/bin/tmuxinator.bash

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
