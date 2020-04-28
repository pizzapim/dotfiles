# Edit PATH variable
set PATH $PATH:$HOME/.local/bin

# Add asdf directory and completions
set ASDF_DIR $HOME/.asdf
if test -d $ASDF_DIR
  source $ASDF_DIR/asdf.fish
  source $ASDF_DIR/completions/asdf.fish
end

# Limit JVM's memory usage
set _JAVA_OPTIONS "-Xmx2g"
set _JAVA_OPTS "-Xmx2g"

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

set PWD_FILE /tmp/whereami

# Save current location after every new command.
function saveloc --on-event fish_prompt
  pwd > $PWD_FILE
end

# Check if the shell is interactive.
if status is-interactive
  # Check if the location file is readable.
  if test -f /tmp/whereami
    # If no other shell is found, start in ~.
    if test (ps -C fish | wc -l) -gt 2
      cd (cat $PWD_FILE)
    else
      cd ~
      pwd > $PWD_FILE
    end
  end
end
