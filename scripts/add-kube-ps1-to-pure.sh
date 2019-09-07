#!/bin/bash

set -e

realpath() {
    perl -MCwd -le 'print Cwd::abs_path(shift)' "$1"
}

scriptpath=$(dirname "$0")
rootpath=$(realpath "$scriptpath/..")

sed "/^\tpreprompt_parts+=('%F{\${prompt_pure_colors\\[path\\]}}%~%f')\$/a\\
\\
\t# kube-ps1\\
\tpreprompt_parts+=('\$(kube_ps1)')\\

/^prompt_pure_setup() {\$/a\\
\t# kube-ps1\\
\tsource '$rootpath/modules/kube-ps1/kube-ps1.sh'\\
\tKUBE_PS1_SEPARATOR='%F{cyan}/%f'\\
\tKUBE_PS1_DIVIDER='%F{cyan}/%f'\\
\tKUBE_PS1_SYMBOL_COLOR=cyan\\
\tKUBE_PS1_CTX_COLOR=cyan\\
\tKUBE_PS1_NS_COLOR=cyan\\
\tKUBE_PS1_PREFIX=''\\
\tKUBE_PS1_SUFFIX=''\\
\\
" "$rootpath/modules/pure/pure.zsh"
