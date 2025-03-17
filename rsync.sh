#!/bin/bash

files=("hypr" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship" "dunst")


echo "=> Syncing Obsidian Vault"
rclone sync -P "$HOME/Obsidian Vault" gdrive:backup/Obsidian

for dir in "${files[@]}"; do
    echo "=> Syncing $dir"
    rclone sync -P "$HOME/.config/$dir" "gdrive:backup/config/$dir"
done

echo "=> Syncing wallpaper"
rclone sync -P "$HOME/Pictures/Wallpaper" gdrive:backup/Wallpaper

echo "=> Syncing Scripts"
rclone sync -P "$HOME/Downloads/Scripts" gdrive:backup/Scripts