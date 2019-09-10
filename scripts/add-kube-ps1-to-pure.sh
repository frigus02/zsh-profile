#!/bin/bash

set -e

realpath() {
	perl -MCwd -le 'print Cwd::abs_path(shift)' "$1"
}

scriptpath=$(dirname "$0")
rootpath=$(realpath "$scriptpath/..")

sed "/^	preprompt_parts+=('%F{\${prompt_pure_colors\\[path\\]}}%~%f')\$/a\\
\\
	# kube-ps1\\
	preprompt_parts+=('\$(kube_ps1)')\\

/^prompt_pure_setup() {\$/a\\
	# kube-ps1\\
	source '$rootpath/modules/kube-ps1/kube-ps1.sh'\\
	KUBE_PS1_SEPARATOR='%F{cyan}/%f'\\
	KUBE_PS1_DIVIDER='%F{cyan}/%f'\\
	KUBE_PS1_SYMBOL_COLOR=cyan\\
	KUBE_PS1_CTX_COLOR=cyan\\
	KUBE_PS1_NS_COLOR=cyan\\
	KUBE_PS1_PREFIX=''\\
	KUBE_PS1_SUFFIX=''\\
\\
" "$rootpath/modules/pure/pure.zsh"
