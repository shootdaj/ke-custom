#!/bin/bash

# Test deployment script - deploys working file as draft profile
# This does NOT add to karabiner.final.json

set -e

# Configuration
SOURCE_FILE="karabiner.json"
KARABINER_DIR="$HOME/.config/karabiner"
TARGET_FILE="$KARABINER_DIR/karabiner.json"

echo "🚀 Starting test deployment..."

# Check if source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "❌ Source file '$SOURCE_FILE' not found!"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "❌ jq is required but not installed. Install with: brew install jq"
    exit 1
fi

# Generate draft profile name
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
PROFILE_NAME="WinKeyMap: $TIMESTAMP | Draft"

echo "📝 Creating draft profile: '$PROFILE_NAME'"

# Create backup of current live config
BACKUP_NAME="karabiner.json.backup.$(date '+%Y-%m-%d_%H-%M-%S')"
if [[ -f "$TARGET_FILE" ]]; then
    cp "$TARGET_FILE" "$KARABINER_DIR/$BACKUP_NAME"
    echo "✅ Backup created: $BACKUP_NAME"
fi

# Read the working profile
WORKING_PROFILE=$(jq -r '.profiles[0]' "$SOURCE_FILE")
if [[ "$WORKING_PROFILE" == "null" ]]; then
    echo "❌ No profiles found in working configuration!"
    exit 1
fi

# Prepare the draft profile with timestamp name
DRAFT_PROFILE=$(echo "$WORKING_PROFILE" | jq --arg name "$PROFILE_NAME" '.name = $name | .selected = true')

# Read existing live configuration
if [[ -f "$TARGET_FILE" ]]; then
    EXISTING_CONFIG=$(cat "$TARGET_FILE")
else
    echo "❌ Live configuration file not found!"
    exit 1
fi

# Deselect all existing profiles
EXISTING_CONFIG=$(echo "$EXISTING_CONFIG" | jq '.profiles[].selected = false')

# Add the draft profile
MERGED_CONFIG=$(echo "$EXISTING_CONFIG" | jq --argjson newProfile "$DRAFT_PROFILE" '.profiles += [$newProfile]')

# Write the merged configuration
echo "$MERGED_CONFIG" > "$TARGET_FILE"

# Get profile count
PROFILE_COUNT=$(echo "$MERGED_CONFIG" | jq '.profiles | length')

echo "✅ Draft profile added: '$PROFILE_NAME'"
echo "📊 Total profiles in live config: $PROFILE_COUNT"

# Restart Karabiner Elements
echo "🔄 Restarting Karabiner Elements..."
osascript -e 'quit app "Karabiner-Elements"' 2>/dev/null || true
sleep 2
open -a "Karabiner-Elements"
echo "✅ Karabiner Elements restarted"

echo ""
echo "🎯 Draft profile '$PROFILE_NAME' is now ACTIVE for testing"
echo "💡 This profile is NOT added to karabiner.final.json"
echo "💡 Use 'deploy-final.sh' to make this permanent"

# Return the profile name for external use
echo "DEPLOYED_PROFILE_NAME=$PROFILE_NAME" 