#!/bin/bash

# Final deployment script - adds tested profile to karabiner.final.json
# This creates a permanent deployment with timestamp-only naming

set -e

# Configuration
SOURCE_FILE="karabiner.json"
FINAL_FILE="karabiner.final.json"
KARABINER_DIR="$HOME/.config/karabiner"
TARGET_FILE="$KARABINER_DIR/karabiner.json"

echo "🚀 Starting final deployment..."

# Check if source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "❌ Source file '$SOURCE_FILE' not found!"
    exit 1
fi

# Check if final file exists
if [[ ! -f "$FINAL_FILE" ]]; then
    echo "❌ Final file '$FINAL_FILE' not found!"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "❌ jq is required but not installed. Install with: brew install jq"
    exit 1
fi

# Generate timestamp-only profile name
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
PROFILE_NAME="WinKeyMap: $TIMESTAMP"

echo "📝 Creating final profile: '$PROFILE_NAME'"

# Create backup of final file
BACKUP_NAME="karabiner.final.json.backup.$(date '+%Y-%m-%d_%H-%M-%S')"
cp "$FINAL_FILE" "$BACKUP_NAME"
echo "✅ Final file backup created: $BACKUP_NAME"

# Read the working profile
WORKING_PROFILE=$(jq -r '.profiles[0]' "$SOURCE_FILE")
if [[ "$WORKING_PROFILE" == "null" ]]; then
    echo "❌ No profiles found in working configuration!"
    exit 1
fi

# Prepare the final profile with timestamp-only name
FINAL_PROFILE=$(echo "$WORKING_PROFILE" | jq --arg name "$PROFILE_NAME" '.name = $name | .selected = true')

# Read existing final configuration
EXISTING_FINAL=$(cat "$FINAL_FILE")

# Deselect all existing profiles in final file
EXISTING_FINAL=$(echo "$EXISTING_FINAL" | jq '.profiles[].selected = false')

# Add the new profile to final file
UPDATED_FINAL=$(echo "$EXISTING_FINAL" | jq --argjson newProfile "$FINAL_PROFILE" '.profiles += [$newProfile]')

# Write the updated final configuration
echo "$UPDATED_FINAL" > "$FINAL_FILE"

# Get profile count
PROFILE_COUNT=$(echo "$UPDATED_FINAL" | jq '.profiles | length')

echo "✅ Final profile added: '$PROFILE_NAME'"
echo "📊 Total profiles in final file: $PROFILE_COUNT"

# Deploy the complete final file to live config
echo "🔄 Deploying final configuration to live config..."
cp "$FINAL_FILE" "$TARGET_FILE"

# Restart Karabiner Elements
echo "🔄 Restarting Karabiner Elements..."
osascript -e 'quit app "Karabiner-Elements"' 2>/dev/null || true
sleep 2
open -a "Karabiner-Elements"
echo "✅ Karabiner Elements restarted"

echo ""
echo "🎯 Final profile '$PROFILE_NAME' is now ACTIVE"
echo "💾 Profile added to karabiner.final.json permanently"
echo "📝 Ready for 'build-version-history' to add documentation"

# Return the profile name for external use
echo "DEPLOYED_PROFILE_NAME=$PROFILE_NAME" 