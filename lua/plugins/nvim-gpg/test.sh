#!/bin/sh
x=$(cat $1 | sed 's/$3/\n/g')
cat << EOF
$x
EOF | gpg -c --quiet > $2
