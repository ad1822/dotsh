#!/bin/bash

notify-send -i "emblem-system" "🧹 Clean Up: Deleting User Cache"
rm -rf ~/.cache/*

notify-send -i "emblem-system" "🧹 Clean Up: Deleting Trash Info"
rm -rf ~/.local/share/Trash/info/*

notify-send -i "emblem-system" "🧹 Clean Up: Deleting Trash Files"
rm -rf ~/.local/share/Trash/files/*

notify-send -i "emblem-system" "🧹 Clean Up: Deleting /tmp"
sudo rm -rf /tmp/*

notify-send -i "emblem-system" "🧹 Clean Up: Deleting Pacman Cache"
#sudo pacman -Sc --noconfirm

notify-send -i "emblem-system" "🧹 Clean Up: Deleting Docker Cache"
#docker system prune -af --volumes

notify-send -i "emblem-system" "✅ Clean Up Complete" "Your system is now tidier!"

