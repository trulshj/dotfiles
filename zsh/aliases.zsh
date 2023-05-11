
# better ls
alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias al='exa -la'

# github
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout -b'

# shortcuts to folders
alias home='cd $HOME'
alias dotfiles='cd $HOME/dotfiles; nvim'
alias dev='cd $HOME/dev'
alias reload='echo "Reloading .zshrc"; source $HOME/.zshrc'

# brew bundle <3
alias brundle='brew bundle --file=$HOME/dotfiles/Brewfile'

# itk
alias cass='mosh cassarossa.samfundet.no'
alias cirk='mosh cirkus.samfundet.no'

# kubernetes
alias k='kubectl'
