#!/bin/bash

files=("hypr" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship" "dunst")

eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/github

for dir in "${files[@]}"; do
    echo "syncing with hyprdots $dir"
    cp -ru ~/.config/$dir ~/hyprdots
done

echo "=> Syncing Local Scripts"
cp -ru "$HOME/.local/bin" ~/hyprdots
