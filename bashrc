alias be='bundle exec'
alias sphinxql='mysql -P9306 --protocol=tcp --prompt="sphinxQL> "'

alias ec2_servers='cd /Users/johngill/projects/myhealthandmoney/devops && bundle exec ruby list_servers.rb'

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

alias kraken="open -na 'GitKraken' --args -p $(pwd)"
alias ll='ls -al'

export EDITOR="vim"
PS1="[\u@$(scutil --get ComputerName) \W]\\$ "

export PATH="/usr/local/bin:/usr/local/sbin:/Users/johngill/.cabal/bin:/opt/nginx/sbin:$PATH"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

source /usr/local/bin/tmuxinator.bash

export DATABASE_USER=johngill
export REPORTING_DATABASE_USER=johngill
export PAGER="less -S"

# https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

#http://ollehost.dk/blog/2013/06/25/install-ruby-2-0-0-p195-using-ruby-build-and-pkg-config/
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:/usr/local/lib/pkgconfig

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
