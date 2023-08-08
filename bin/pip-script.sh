#!/bin/sh

if ! pip install --upgrade --ignore-installed "$@"
then
    pip install --upgrade --ignore-installed --break-system-packages "$@"
fi
