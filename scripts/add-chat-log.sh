#!/bin/bash

# Helper script to organize AI chat logs from exported files
# Usage: ./scripts/add-chat-log.sh
#        Automatically processes the latest file in docs/chats/exported/

set -e

EXPORTED_DIR="docs/chats/exported"
CHATS_DIR="docs/chats"

# Function to process an exported file
process_exported_file() {
    local source_file="$1"
    
    # Generate filename with date and time
    local datetime=$(date +%Y-%m-%d_%H-%M-%S)
    local filename="${CHATS_DIR}/${datetime}.md"
    
    # Copy the exported content exactly as-is
    cp "$source_file" "$filename"
    
    echo "✅ Created chat log: $filename"
    
    # Automatically delete the original
    rm "$source_file"
    echo "🗑️  Deleted original file: $(basename "$source_file")"
}

# Check if exported directory exists
if [ ! -d "$EXPORTED_DIR" ]; then
    echo "Creating exported directory: $EXPORTED_DIR"
    mkdir -p "$EXPORTED_DIR"
fi

# Find the most recently modified .md file (macOS compatible)
latest_file=$(find "$EXPORTED_DIR" -name "*.md" -type f -exec stat -f "%m %N" {} \; 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)

if [ -z "$latest_file" ] || [ ! -f "$latest_file" ]; then
    echo "❌ No exported files found in $EXPORTED_DIR"
    echo "Export your chat from Cursor to: $EXPORTED_DIR/ and run this script again."
    exit 1
fi

echo "📄 Processing: $(basename "$latest_file")"
process_exported_file "$latest_file" 