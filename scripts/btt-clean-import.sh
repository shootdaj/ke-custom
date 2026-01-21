#!/bin/bash

# DESTRUCTIVE: Erases ALL existing BTT config and imports from repo
# Use this for a clean setup on a new machine or to reset BTT completely

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PRESET_FILE="$REPO_DIR/btt/btt-preset.bttpreset"

if [[ ! -f "$PRESET_FILE" ]]; then
    echo "❌ Preset file not found: $PRESET_FILE"
    exit 1
fi

echo ""
echo "⚠️  =============================================="
echo "⚠️  WARNING: THIS WILL DELETE ALL YOUR BTT CONFIG"
echo "⚠️  =============================================="
echo ""
echo "This script will:"
echo "  1. DELETE all existing BetterTouchTool presets"
echo "  2. Import the preset from this repo"
echo ""
echo "Your current BTT shortcuts, gestures, and settings WILL BE LOST."
echo ""
read -p "Type 'DELETE' to confirm: " confirm

if [[ "$confirm" != "DELETE" ]]; then
    echo "❌ Aborted. Nothing was changed."
    exit 1
fi

echo ""
echo "🗑️  Deleting existing BTT presets..."

# Delete the Default preset (main one)
osascript -e 'tell application "BetterTouchTool" to delete_preset "Default"' 2>/dev/null

# Small delay to let BTT process
sleep 1

echo "📥 Importing preset from repo..."
osascript -e "tell application \"BetterTouchTool\" to import_preset \"$PRESET_FILE\""

echo ""
echo "✅ Clean import complete."
echo "   Check BetterTouchTool to verify your config."
