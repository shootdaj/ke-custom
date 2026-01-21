#!/bin/bash

# Simple deploy script - backup current config and deploy new one
# Usage: ./scripts/deploy.sh

set -e

SOURCE_FILE="karabiner.json"
KARABINER_DIR="$HOME/.config/karabiner"
TARGET_FILE="$KARABINER_DIR/karabiner.json"
BACKUP_FILE="$KARABINER_DIR/karabiner.json.backup"

echo "🚀 Deploying karabiner config..."

# Check if source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "❌ Source file '$SOURCE_FILE' not found!"
    exit 1
fi

# Backup current config (single backup, overwritten each deploy)
if [[ -f "$TARGET_FILE" ]]; then
    cp "$TARGET_FILE" "$BACKUP_FILE"
    echo "✅ Backup saved to: $BACKUP_FILE"
fi

# Deploy new config
cp "$SOURCE_FILE" "$TARGET_FILE"
echo "✅ Config deployed"

# Restart Karabiner Elements
echo "🔄 Restarting Karabiner Elements..."
osascript -e 'quit app "Karabiner-Elements"' 2>/dev/null || true
sleep 2
open -a "Karabiner-Elements"

echo "✅ Done. Test your changes."
echo "💡 Run './scripts/revert.sh' to restore previous config if needed."
