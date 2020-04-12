# Edit PATH variable
set PATH $PATH:$HOME/.local/bin

# Add asdf directory and completions
set ASDF_DIR $HOME/.asdf
if test -d $ASDF_DIR
  source $ASDF_DIR/asdf.fish
  source $ASDF_DIR/completions/asdf.fish
end

# Abbreviations
abbr l 'ls -CF'
abbr gp 'git push'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr gc 'git commit'
abbr gpl 'git pull'
abbr gs 'git status'
abbr gb 'git branch'
abbr ga 'git add'
abbr gl 'git log'
abbr xdg 'xdg-open'
abbr update 'sudo apt update'
abbr upgrade 'sudo apt upgrade'

# Aliases
alias vi 'nvim'
