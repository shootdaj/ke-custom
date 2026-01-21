#!/bin/bash

# Import BTT preset from repo
# Run this on a new machine to load the config

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PRESET_FILE="$REPO_DIR/btt/btt-preset.bttpreset"

if [[ ! -f "$PRESET_FILE" ]]; then
    echo "❌ Preset file not found: $PRESET_FILE"
    exit 1
fi

echo "🔄 Importing BTT preset..."
echo "⚠️  This will add to your existing BTT config (won't replace)"

osascript -e "tell application \"BetterTouchTool\" to import_preset \"$PRESET_FILE\""

echo "✅ Import complete. Check BTT to verify."
