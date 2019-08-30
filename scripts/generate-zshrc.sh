#!/bin/bash

set -e

realpath() {
    perl -MCwd -le 'print Cwd::abs_path(shift)' "$1"
}

scriptpath=$(dirname "$0")
rootpath=$(realpath "$scriptpath/..")

cat <<EOF
#!/bin/zsh

source "$rootpath/zshrc"
EOF
