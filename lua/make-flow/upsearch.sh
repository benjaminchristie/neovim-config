#!/bin/bash
slashes=${PWD//[^\/]/}
directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/Makefile" && echo "$directory/Makefile" && exit
    directory="$directory/.."
  done
