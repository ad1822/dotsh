#!/usr/bin/env python3
import os
from pathlib import Path

def rename_wallpapers():
    # Set the wallpaper directory path
    wallpaper_dir = Path.home() / "Pictures" / "Wallpaper"

    # Check if directory exists
    if not wallpaper_dir.exists():
        print(f"Error: Directory not found - {wallpaper_dir}")
        return

    # Get all files in the directory
    files = [f for f in wallpaper_dir.iterdir() if f.is_file()]

    # Sort files by name for consistent ordering
    files.sort()

    # Counter for new filenames
    counter = 1

    # Rename each file
    for old_file in files:
        # Get file extension
        extension = old_file.suffix.lower()

        # Skip hidden files (like .DS_Store on macOS)
        if old_file.name.startswith('.'):
            continue

        # Create new filename
        new_name = f"wallpaper_{counter:03}{extension}"
        new_file = wallpaper_dir / new_name

        # Check if new filename already exists to avoid overwriting
        while new_file.exists():
            counter += 1
            new_name = f"wallpaper_{counter:03}{extension}"
            new_file = wallpaper_dir / new_name

        try:
            # Rename the file
            old_file.rename(new_file)
            print(f"Renamed: {old_file.name} -> {new_name}")
            counter += 1
        except Exception as e:
            print(f"Error renaming {old_file.name}: {e}")

if __name__ == "__main__":
    print("Starting wallpaper renaming...")
    rename_wallpapers()
    print("Wallpaper renaming complete!")