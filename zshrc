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
PROMPT='
%F{cyan}%~%f
%(?.%F{green}.%F{red})❯%f '
if command -v starship >/dev/null; then
	eval "$(starship init zsh)"
elif [[ "$FRIGUS02_ZSH_PROFILE_DEBUG" != false ]]; then
	echo "required for prompt: starship"
fi

# Word style: directory delimiter
autoload -U select-word-style
select-word-style bash

# Key bindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^[B" backward-word
bindkey "^[b" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[F" forward-word
bindkey "^[f" forward-word
bindkey "^[[1;5C" forward-word
bindkey "^[D" kill-word
bindkey "^[d" kill-word

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100
source "$scriptpath/modules/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
source "$scriptpath/modules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

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
if command -v gpgconf gpg-agent >/dev/null; then
	AGENT_SOCK=$(gpgconf --list-dirs | grep agent-socket | cut -d : -f 2)
	if [[ ! -S $AGENT_SOCK ]]; then
		gpg-agent --daemon --use-standard-socket &>/dev/null
	fi
	export GPG_TTY=$TTY
elif [[ "$FRIGUS02_ZSH_PROFILE_DEBUG" != false ]]; then
	echo "required for gpg: gpgconf, gog-agent"
fi

# Editor
if command -v nvim >/dev/null; then
	alias vim=nvim
fi
export EDITOR=vim

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
	source "$HOME/.fzf.zsh"
fi
if command -v fzf >/dev/null; then
	if [[ -d /usr/share/doc/fzf/examples/ ]]; then
		source /usr/share/doc/fzf/examples/key-bindings.zsh
		source /usr/share/doc/fzf/examples/completion.zsh
	fi
elif [[ "$FRIGUS02_ZSH_PROFILE_DEBUG" != false ]]; then
	echo "required for fuzzy searches: fzf"
fi

# curl-history
if command -v curl fzf rg >/dev/null; then
	source "$scriptpath/modules/curl-history/curl-history.sh"
elif [[ "$FRIGUS02_ZSH_PROFILE_DEBUG" != false ]]; then
	echo "required for curl-history: curl, fzf and rg"
fi
