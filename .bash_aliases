alias da="direnv allow"
alias pstat="netstat -plten"
alias running="ps x"
alias start-the-day="git fetch origin +master:master +production:production +canary:canary && git stash -u && git checkout master && pip-sync dev-requirements.txt requirements.txt && yarn && pym migrate && git fetch --prune && git sb"
