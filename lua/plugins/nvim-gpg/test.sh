#!/bin/sh
x=$(echo $1 | sed "s/$3/\n/g")
gpg -c --quiet --yes -o $2 <<HEREDOC
$x
HEREDOC
