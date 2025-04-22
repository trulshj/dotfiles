# better cd
alias cd='z'

# better ls
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias al='lsd -al'

# github
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout -b'

# shortcuts to folders
alias home='echo "Country roads"; cd $HOME'
alias takemehome='echo "Country roads"; cd $HOME'
alias dotfiles='cd $HOME/dotfiles; nvim'
alias dev='cd $HOME/dev'
alias reload='echo "Reloading .zshrc"; source $HOME/.zshrc'

# brew bundle <3
alias brundle='brew bundle --file=$HOME/dotfiles/Brewfile'

# itk
alias cass='mosh cassarossa.samfundet.no'
alias cirk='mosh cirkus.samfundet.no'
alias stu='samba-tool user'
alias stg='samba-tool group'

# kubernetes
alias k='kubectl'

# docker
alias dps='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.State}}"'

# exercism
alias exs='exercism submit'
alias mxta="mix test --include pending"
