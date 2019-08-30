#!/bin/zsh

#
# zsh config
#

fpath=("$HOME/.zfunctions" $fpath)

# Completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

# Pure prompt
autoload -U promptinit && promptinit
prompt pure

# Word style: directory delimiter
autoload -U select-word-style
select-word-style bash

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Menu selection
zstyle ':completion:*' menu select

# History
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#
# Application config
#

export PATH="$HOME/bin:$PATH"

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gst='git status'

# ls
export CLICOLOR=1
alias ll='ls -l'
alias la='ls -a'

# Go
export PATH="$PATH:$(go env GOPATH)/bin"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
source "$HOME/.zfunctions/zsh-nvm"

# Android
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export ANDROID_SDK_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_SDK_HOME/platform-tools:$ANDROID_SDK_HOME/tools/bin"
alias emulator=$HOME/Library/Android/sdk/tools/emulator
decompile() {
	source=$1
	destination=$2
	mkdir "$destination"
	java -cp "/Applications/Android Studio.app/Contents/plugins/java-decompiler/lib/java-decompiler.jar" org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler "$source" "$destination"
}

# Terraform
source "/usr/local/share/chtf/chtf.sh"
chtf 0.11.14

# Kubernetes
alias k=kubectl
alias ktx='kubectl config use-context'
alias kns='kubectl config set-context $(kubectl config current-context) --namespace'
alias kgp='kubectl get pod'

# GPG
AGENT_SOCK=$(gpgconf --list-dirs | grep agent-socket | cut -d : -f 2)
if [[ ! -S $AGENT_SOCK ]]; then
	gpg-agent --daemon --use-standard-socket &>/dev/null
fi
export GPG_TTY=$TTY

# Editor
export EDITOR='code -w'

# Todo
alias t=todo.sh