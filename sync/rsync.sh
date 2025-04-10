#!/bin/bash

CYAN="\e[36m"
PURPLE="\e[0;35m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

files=("hypr" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship" "dunst")

echo -e "${PURPLE}📁 => Syncing Obsidian Vault...${RESET}"
rclone sync -P "$HOME/Obsidian Vault" gdrive:backup/Obsidian  --exclude=".git/**" && echo -e "${GREEN}✔ Obsidian Vault synced!${RESET}\n"

for dir in "${files[@]}"; do
    echo -e "${CYAN}⚙️  => Syncing ${YELLOW}${dir}${CYAN} config...${RESET}"
    rclone sync -P "$HOME/.config/$dir" "gdrive:backup/config/$dir" && echo -e "${GREEN}✔ ${dir} synced!${RESET}\n"
done

echo -e "${GREEN}🖼  => Syncing Wallpapers...${RESET}"
rclone sync -P "$HOME/Pictures/Wallpaper" gdrive:backup/Wallpaper && echo -e "${GREEN}✔ Wallpapers synced!${RESET}\n"

echo -e "${CYAN}📜 => Syncing Scripts...${RESET}"
rclone sync -P "$HOME/SideProjects/dotsh" gdrive:backup/dotsh --exclude=".git/**" && echo -e "${GREEN}✔ Scripts synced!${RESET}\n"
