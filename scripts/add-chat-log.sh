#!/bin/bash

# Helper script to organize AI chat logs from exported files
# Usage: ./scripts/add-chat-log.sh [topic-description] [ai-assistant]
#        If no args, will process the latest file in docs/chats/exported/

set -e

EXPORTED_DIR="docs/chats/exported"
CHATS_DIR="docs/chats"

# Function to process an exported file
process_exported_file() {
    local source_file="$1"
    local topic="$2"
    local ai_assistant="${3:-cursor}"
    
    # Get current date and clean topic
    local date=$(date +%Y-%m-%d)
    local clean_topic=$(echo "$topic" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    local filename="${CHATS_DIR}/${date}_${clean_topic}.md"
    
    # Capitalize titles
    local topic_title=$(echo "$topic" | sed 's/\b\w/\U&/g')
    local ai_title=$(echo "$ai_assistant" | sed 's/\b\w/\U&/g')
    
    # Create organized file with template
    cat > "$filename" << EOF
# $topic_title - $(date +"%B %d, %Y")

**AI Assistant:** $ai_title
**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Topic:** $topic

---

## Session Summary

<!-- Brief overview of what was accomplished in this session -->

## Key Decisions

<!-- Important decisions made during this conversation -->

## Code Changes

<!-- List of files modified, created, or deleted -->

## Issues Encountered

<!-- Any problems faced and how they were resolved -->

## Outstanding Items

<!-- TODOs, questions, or items for future sessions -->

## Related Links

<!-- Links to commits, issues, documentation, etc. -->

---

## Chat Export

EOF

    # Append the exported content
    cat "$source_file" >> "$filename"
    
    echo "✅ Created organized chat log: $filename"
    
    # Ask if user wants to delete the original
    echo ""
    read -p "Delete the original exported file ($source_file)? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$source_file"
        echo "🗑️  Deleted original file"
    else
        echo "📁 Keeping original file"
    fi
    
    # Remind user to update index
    echo ""
    echo "📋 Don't forget to update docs/chats/README.md with this new entry:"
    echo "   | $date | [${date}_${clean_topic}.md](./${date}_${clean_topic}.md) | $topic | $ai_title | <!-- Add key outcomes --> |"
    
    # Open in editor
    if command -v code &> /dev/null; then
        echo "📝 Opening in VS Code..."
        code "$filename"
    fi
}

# Check if exported directory exists
if [ ! -d "$EXPORTED_DIR" ]; then
    echo "Creating exported directory: $EXPORTED_DIR"
    mkdir -p "$EXPORTED_DIR"
fi

# If arguments provided, use them (backward compatibility)
if [ $# -gt 0 ]; then
    topic="$1"
    ai_assistant="${2:-cursor}"
    
    # Check for latest exported file (macOS compatible)
    latest_file=$(find "$EXPORTED_DIR" -name "*.md" -type f -exec stat -f "%m %N" {} \; 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    
    if [ -n "$latest_file" ] && [ -f "$latest_file" ]; then
        echo "Found latest exported file: $(basename "$latest_file")"
        process_exported_file "$latest_file" "$topic" "$ai_assistant"
    else
        echo "No exported files found in $EXPORTED_DIR"
        echo "Please export your chat from Cursor to: $EXPORTED_DIR/"
        echo "Then run this script again."
        exit 1
    fi
else
    # Interactive mode - find latest file and ask for topic
    echo "🔍 Looking for exported chat files..."
    
    # Find the most recently modified .md file (macOS compatible)
    latest_file=$(find "$EXPORTED_DIR" -name "*.md" -type f -exec stat -f "%m %N" {} \; 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    
    if [ -z "$latest_file" ] || [ ! -f "$latest_file" ]; then
        echo "❌ No exported files found in $EXPORTED_DIR"
        echo ""
        echo "To use this script:"
        echo "1. Export your chat from Cursor to: $EXPORTED_DIR/"
        echo "2. Run this script again"
        echo ""
        echo "Alternative: Run with arguments:"
        echo "   $0 \"topic-description\" \"ai-assistant\""
        exit 1
    fi
    
    echo "📄 Found: $(basename "$latest_file")"
    echo "📅 Modified: $(stat -f "%Sm" "$latest_file")"
    echo ""
    
    # Ask user for topic
    read -p "Enter topic description for this chat: " topic
    if [ -z "$topic" ]; then
        echo "❌ Topic is required"
        exit 1
    fi
    
    read -p "AI Assistant used [cursor]: " ai_assistant
    ai_assistant="${ai_assistant:-cursor}"
    
    process_exported_file "$latest_file" "$topic" "$ai_assistant"
fi 