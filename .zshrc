# Homebrew setup
export PATH="/opt/homebrew/bin:$PATH"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS

# Key bindings
bindkey '^R' history-incremental-search-backward  # Ctrl+R for search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Colored incremental search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Basic aliases
alias ll='ls -lah'
alias la='ls -la'
alias l='ls -l'
alias vi='vim'
alias grep='rg'  # requires ripgrep: brew install ripgrep

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias glog='git log --oneline --graph --decorate'

# Docker and Kubernetes (if you use them)
alias k='kubectl'
alias d='docker'

# Terraform (if you use it)
alias tf='terraform'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias proj='cd ~/projects'  # Adjust to your projects directory

# Utility aliases
alias reload='source ~/.zshrc'
alias zshconfig='vim ~/.zshrc'
alias gitconfig='vim ~/.gitconfig'

# Git branch cleanup (removes all branches except main/master)
alias gclean='git branch | grep -v -E "(main|master)" | xargs git branch -D'

# Git commit amend shortcuts
alias gamend='git commit -a --amend --no-verify --no-edit'
alias gfpush='git push --force-with-lease'

# fzf integration (requires: brew install fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zsh plugins (requires installation via brew)
# brew install zsh-syntax-highlighting zsh-autosuggestions
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Git status in prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'
setopt PROMPT_SUBST

# Custom prompt
PROMPT='%F{blue}%1~%f ${vcs_info_msg_0_} %# '

# Node Version Manager (NVM) - uncomment if you use Node.js
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# SDKMAN (for Java/Scala development) - uncomment if needed
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract function for various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Load local/private configuration if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local