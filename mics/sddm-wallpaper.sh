#!/bin/bash

cat <<'EOF' | lolcat

███████╗██████╗ ██████╗ ███╗   ███╗
██╔════╝██╔══██╗██╔══██╗████╗ ████║
███████╗██║  ██║██║  ██║██╔████╔██║
╚════██║██║  ██║██║  ██║██║╚██╔╝██║
███████║██████╔╝██████╔╝██║ ╚═╝ ██║
╚══════╝╚═════╝ ╚═════╝ ╚═╝     ╚═╝

EOF


TARGET="$HOME/Pictures/Wallpaper"
WALLPAPER=$(find "$TARGET" -type f -regex '.*\.jpg' | shuf -n 1)

echo "Selected wallpaper: $WALLPAPER"

DEST_DIR="/usr/share/sddm/themes/catppuccin-mocha/backgrounds"
DEST_FILE="$DEST_DIR/sddm2.jpg"

sudo cp "$WALLPAPER" "$DEST_FILE"

echo "Wallpaper updated successfully!"
