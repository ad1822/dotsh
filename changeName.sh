#!/bin/bash

count=1
for f in *.{jpg,jpeg,png}; do
    [ -e "$f" ] || continue
    ext="${f##*.}"
    echo "Renaming: $f"
    mv "$f" "wallpaper$count.$ext"
    ((count++))
done
