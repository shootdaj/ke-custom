#!/bin/bash

# Export BTT preset to repo
# Run this to save your current BTT config

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PRESET_FILE="$REPO_DIR/btt/btt-preset.bttpreset"

echo "🔄 Exporting BTT preset..."

osascript -e "tell application \"BetterTouchTool\" to export_preset \"Default\" outputPath \"$PRESET_FILE\" with includeSettings"

if [[ -f "$PRESET_FILE" ]]; then
    echo "✅ Exported to: btt-preset.bttpreset"
    ls -lh "$PRESET_FILE"
else
    echo "❌ Export failed"
    exit 1
fi
