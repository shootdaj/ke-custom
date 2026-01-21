#!/bin/bash

# Revert to previous config from backup
# Usage: ./scripts/revert.sh

set -e

KARABINER_DIR="$HOME/.config/karabiner"
TARGET_FILE="$KARABINER_DIR/karabiner.json"
BACKUP_FILE="$KARABINER_DIR/karabiner.json.backup"

echo "🔄 Reverting to previous config..."

# Check if backup exists
if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "❌ No backup found at: $BACKUP_FILE"
    exit 1
fi

# Restore backup
cp "$BACKUP_FILE" "$TARGET_FILE"
echo "✅ Config restored from backup"

# Restart Karabiner Elements
echo "🔄 Restarting Karabiner Elements..."
osascript -e 'quit app "Karabiner-Elements"' 2>/dev/null || true
sleep 2
open -a "Karabiner-Elements"

echo "✅ Done. Previous config restored."
