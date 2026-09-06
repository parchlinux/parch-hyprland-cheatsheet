#!/usr/bin/bash

dir="$(dirname "$(readlink -f "$0")")"
exec qs -p "$dir/cheatsheet.qml"
