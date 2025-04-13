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
DEST_DIR="/usr/share/sddm/themes/catppuccin-mocha/backgrounds"
TEMP_IMG="$HOME/sddm.jpg"
DEST_FILE="$DEST_DIR/sddm.jpg"

WALLPAPER=$(find "$TARGET" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | shuf -n 1)


if [[ -z "$WALLPAPER" ]]; then
    echo "No supported image files found in $TARGET."
    exit 1
fi


magick "$WALLPAPER" "$TEMP_IMG"

if [[ ! -d "$DEST_DIR" ]]; then
    echo "Destination directory does not exist: $DEST_DIR"
    exit 1
fi

sudo cp "$TEMP_IMG" "$DEST_FILE"
rm $TEMP_IMG

notify-send -a "hyprpaper" "Lock Screen Wallpaper Changed"  -i "$WALLPAPER"
