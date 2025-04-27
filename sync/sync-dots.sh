#!/bin/bash
cat <<'EOF' | lolcat

   * *
*   * *
 **    **

  *     *
       *
 *   *

      *
*
   *


EOF

GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
RESET="\e[0m"

files=("hypr" "git" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship" "dunst")

for dir in "${files[@]}"; do
    echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}${dir}${RESET}"
    cp -ru ~/.config/$dir ~/hyprdots
done

echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}Local Scripts${RESET}"
cp -ru "$HOME/.local/bin" ~/hyprdots

echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}.zshrc${RESET}"
cp -ru "$HOME/.zshrc" ~/hyprdots/zsh/.zshrc
