#!/bin/bash

echo "Running Script"

# Define path for package list
# path="$HOME/Downloads/Scripts/download_packages.txt"

# # Install pacman packages from the list
# if [[ -f "$path" ]]; then
#     sudo pacman -S --needed - < "$path"
# else
#     echo "Package list not found: $path"
#     exit 1
# fi

# Create fonts directory
mkdir -p ~/.local/share/fonts/fontawesome

echo "Installing Font Awesome Icon pack (Version 5 and 6)"
if [[ ! -f ~/.local/share/fonts/fontawesome/fa-brands-400.ttf ]]; then
    wget -q https://use.fontawesome.com/releases/v6.7.2/fontawesome-free-6.7.2-desktop.zip
    unzip fontawesome-free-6.7.2-desktop.zip -d ~/.local/share/fonts/fontawesome
    # mv fontawesome6/otfs/*.otf ~/.local/share/fonts/fontawesome/
    rm -rf fontawesome6 fontawesome-free-6.7.2-desktop.zip
    
    wget -q https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
    unzip fontawesome-free-5.15.4-desktop.zip -d ~/.local/share/fonts/fontawesome
    # mv fontawesome5/otfs/*.otf ~/.local/share/fonts/fontawesome/
    rm -rf fontawesome5 fontawesome-free-5.15.4-desktop.zip
else
    echo "Font Awesome already installed, skipping download."
fi

echo "Installing JetBrains Nerd Fonts"
mkdir -p ~/.local/share/fonts/JetBrainsMono
if [[ ! -f ~/.local/share/fonts/JetBrainsMono/JetBrainsMono-Regular.ttf ]]; then
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip -q JetBrainsMono.zip -d JetBrainsMono
    mv JetBrainsMono/*.ttf ~/.local/share/fonts/JetBrainsMono/
    rm -rf JetBrainsMono JetBrainsMono.zip
else
    echo "JetBrains Nerd Fonts already installed, skipping download."
fi

# Refresh font cache
fc-cache -fv

echo "Setup completed successfully!"
