#!/bin/bash


cat <<'EOF' | lolcat
  ___ __ _____  ____
 (_-</ // / _ \/ __/
/___/\_, /_//_/\__/
    /___/

EOF

CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

hyprdots="$HOME/SideProjects/dotsh/sync/sync-dots.sh"
repo="$HOME/SideProjects/dotsh/sync/push-dots.sh"
cloud="$HOME/SideProjects/dotsh/sync/rsync.sh"
obsidian="$HOME/SideProjects/dotsh/sync/sync-obsidian-vault.sh"

echo -e "${CYAN}===> Syncing Hyprdots...${RESET}"
bash "$hyprdots" && echo -e "${GREEN} ✔ Hyprdots synced successfully!${RESET}\n" || echo -e "${YELLOW}✖ Failed to sync Hyprdots${RESET}\n"

echo -e "${CYAN}===> Pushing to ${GREEN}Hyprdots ${CYAN}on GitHub  ...${RESET}"
bash "$repo" && echo -e "${GREEN} ✔ Changes pushed to GitHub!${RESET}\n" || echo -e "${YELLOW}✖ GitHub push failed${RESET}\n"

echo -e "${CYAN}===> Syncing with Cloud...${RESET}"
bash "$cloud" && echo -e "${GREEN} ✔ Cloud sync complete!${RESET}\n" || echo -e "${YELLOW}✖ Cloud sync failed${RESET}\n"


echo -e "${CYAN}===> Pushing to ${GREEN}Obsidian Vault ${CYAN}on GitHub  ...${RESET}"
bash "$obsidian" && echo -e "${GREEN} ✔ Changes pushed to GitHub!${RESET}\n" || echo -e "${YELLOW}✖ GitHub push failed${RESET}\n"