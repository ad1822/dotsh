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

files=("hypr" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship" "dunst")

eval "$(ssh-agent -s)" > /dev/null
    OUTPUT=$(ssh-add ~/.ssh/github 2>&1)

    if [[ $OUTPUT =~ Identity\ added:\ .*\((.*)\) ]]; then
      EMAIL=${BASH_REMATCH[1]}
      echo -e "\e[1;32m ✔ Identity added for:\e[0m ${BLUE}$EMAIL\e[0m"
    else
      echo -e "\e[1;31m✖ Failed to add identity\e[0m"
      echo -e "\e[0;90m$OUTPUT\e[0m"
    fi


for dir in "${files[@]}"; do
    echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}${dir}${RESET}"
    cp -ru ~/.config/$dir ~/hyprdots
done

echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}Local Scripts${RESET}"
cp -ru "$HOME/.local/bin" ~/hyprdots

echo -e "${BLUE}=> Syncing with hyprdots ${YELLOW}.zshrc${RESET}"
cp -ru "$HOME/.zshrc" ~/hyprdots/zsh/.zshrc
