#!/bin/zsh

#
# zsh config
#

fpath=("$HOME/.zfunctions" $fpath)
scriptpath=$(dirname "$0")

# Completions
fpath=("$scriptpath/modules/zsh-completions/src" $fpath)
autoload -U compinit && compinit

# Prompt
eval "$(starship init zsh)"

# Word style: directory delimiter
autoload -U select-word-style
select-word-style bash

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100
source "$scriptpath/modules/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
export ZSH_HIGHLIGHT_MAXLENGTH=100
source "$scriptpath/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-history-substring-search
source "$scriptpath/modules/zsh-history-substring-search/zsh-history-substring-search.zsh"
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
if command -v go >/dev/null; then
	export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
source "$scriptpath/modules/zsh-nvm/zsh-nvm.plugin.zsh"

# Android
enable_android() {
	export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
	export ANDROID_SDK_HOME="$HOME/Library/Android/sdk"
	export PATH="$PATH:$ANDROID_SDK_HOME/platform-tools:$ANDROID_SDK_HOME/tools/bin"
	alias emulator=$HOME/Library/Android/sdk/tools/emulator
	android_decompile() {
		source=$1
		destination=$2
		mkdir "$destination"
		java -cp "/Applications/Android Studio.app/Contents/plugins/java-decompiler/lib/java-decompiler.jar" org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler "$source" "$destination"
	}
}

# Terraform
if [[ -f /usr/local/share/chtf/chtf.sh ]]; then
	source /usr/local/share/chtf/chtf.sh
fi

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
if command -v nvim >/dev/null; then
	alias vim="nvim"
fi
export EDITOR=vim
