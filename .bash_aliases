# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git aliases
alias gp='git push'
alias gco='git checkout'
alias gd='git diff'
alias gc='git commit'
alias gpl='git pull'
alias gs='git status'
alias gb='git branch'
alias ga='git add'
alias gl='git log'

_completion_loader git
__git_complete gp _git_push
__git_complete gco _git_checkout
__git_complete gd _git_diff
__git_complete gc _git_commit
__git_complete gpl _git_pull
__git_complete gs _git_status
__git_complete gb _git_branch
__git_complete ga _git_add
__git_complete gl _git_log

alias xdg='xdg-open'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'

alias vi='nvim'
