#!/bin/bash

set -e

sed $'/^	preprompt_parts\\+=(\'%F{${prompt_pure_colors\\[path\\]}}%~%f\')$/a\
\
\t# kube-ps1\
\tpreprompt_parts+=(\'$(kube_ps1)\')\

/^prompt_pure_setup() {$/a\
\t# kube-ps1\
\tsource /usr/local/opt/kube-ps1/share/kube-ps1.sh\
\tKUBE_PS1_SEPARATOR=\'%F{cyan}/%f\'\
\tKUBE_PS1_DIVIDER=\'%F{cyan}/%f\'\
\tKUBE_PS1_SYMBOL_COLOR=cyan\
\tKUBE_PS1_CTX_COLOR=cyan\
\tKUBE_PS1_NS_COLOR=cyan\
\tKUBE_PS1_PREFIX=\'\'\
\tKUBE_PS1_SUFFIX=\'\'\
\
' "$1"
