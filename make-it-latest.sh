#!/bin/bash

set -e  # Stop on error

cd ~/SideProjects/dotsh || exit 1

for dir in gh mics sync; do
    echo "📂 Processing $dir"
    for script in "$dir"/*.sh; do
        [ -e "$script" ] || continue
        
        filename=$(basename "$script" .sh)
        newpath="$dir/$filename"
        
        mv "$script" "$newpath"
        echo "==> Renamed: $script → $newpath"
    done
done

for dir in gh mics sync; do
    echo "📤 Copying $dir scripts to /usr/local/bin"
    sudo cp "$dir"/* /usr/local/bin/
done

echo "✅ All done! Your scripts are now globally executable 🎉"
