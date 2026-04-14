#!/usr/bin/env bash

# Paths
THEME_DIR="$HOME/.local/share/icons/Breeze-Dynamic"
CACHE_FILE="$HOME/.cache/wal/colors.json"
BREEZE_PATH="/run/current-system/sw/share/icons/breeze-dark" # Fallback path

# Detect Breeze path if not in the default location
if [ ! -d "$BREEZE_PATH" ]; then
    BREEZE_PATH=$(find /nix/store -maxdepth 2 -name "*breeze-icons*" -type d | head -n 1)/share/icons/breeze-dark
fi

# Ensure theme directory exists
mkdir -p "$THEME_DIR"

# Initial setup: Copy core Breeze structure if empty
if [ ! -f "$THEME_DIR/index.theme" ]; then
    echo "Initial setup: Copying Breeze icon structure..."
    cat <<EOF > "$THEME_DIR/index.theme"
[Icon Theme]
Name=Breeze-Dynamic
Comment=Dynamic Breeze icons that follow your wallpaper
Inherits=breeze-dark,breeze,hicolor
Directories=places/32,places/48,places/64

[places/32]
Size=32
Context=Places
Type=Fixed

[places/48]
Size=48
Context=Places
Type=Fixed

[places/64]
Size=64
Context=Places
Type=Fixed
EOF

    # Copy folder icons
    mkdir -p "$THEME_DIR/places"
    cp -r "$BREEZE_PATH/places/"{32,48,64} "$THEME_DIR/places/"
    chmod -R u+w "$THEME_DIR/places"
fi

# Get the target color from Matugen/Wal
if [ -f "$CACHE_FILE" ]; then
    # We use color2 as it's typically a good vibrant accent color
    COLOR=$(jq -r '.colors.color2' "$CACHE_FILE")
else
    COLOR="#3daee9" # Default Breeze Blue
fi

echo "Updating folder colors to: $COLOR"

# Replace the Breeze Blue (#3daee9) with our dynamic color
# Also replace the darker blue (#2980b9) with a 20% darker version of our color
find "$THEME_DIR/places" -name "folder*.svg" -type f -exec sed -i "s/#3daee9/$COLOR/gI" {} +

# Update icon cache to trigger the change
gtk-update-icon-cache -f -t "$THEME_DIR"

echo "Done!"
