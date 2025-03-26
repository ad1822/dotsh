#!/usr/bin/env bash

# Hyprpaper Wallpaper Selector with Yazi (corrected syntax)
TARGET_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpaper}"
CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"

# Check dependencies
if ! command -v yazi &> /dev/null; then
    echo "Error: Yazi is required but not installed." >&2
    exit 1
fi

if ! command -v kitty &> /dev/null; then
    echo "Error: Kitty terminal is required for preview." >&2
    exit 1
fi

# Ensure wallpaper directory exists
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Wallpaper directory not found: $TARGET_DIR" >&2
    exit 1
fi

# Temporary file to store Yazi's selection
TEMP_FILE=$(mktemp)

# Launch Yazi in file picker mode with Kitty preview
yazi --chooser-file "$TEMP_FILE" "$TARGET_DIR"

# Read the selected file
WALLPAPER=$(cat "$TEMP_FILE")
rm "$TEMP_FILE"  # Clean up

# Exit if no selection
if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    echo "No wallpaper selected. Exiting."
    exit 0
fi

# Update Hyprpaper config
mkdir -p "$(dirname "$CONFIG_PATH")"
{
    echo "preload = $WALLPAPER"
    echo "wallpaper = eDP-1,$WALLPAPER"
    echo "splash = false"
    echo "ipc = false"
} > "$CONFIG_PATH"

# Restart Hyprpaper
pkill hyprpaper
hyprpaper &> /dev/null &

# Notification
notify-send -a "hyprpaper" "Wallpaper Changed" "$(basename "$WALLPAPER")" -i "$WALLPAPER"
echo "Wallpaper set to: $WALLPAPER"