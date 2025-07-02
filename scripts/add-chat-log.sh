#!/bin/bash

# Helper script to create and organize new AI chat logs
# Usage: ./scripts/add-chat-log.sh "topic-description" ["ai-assistant"]

set -e

# Check if topic is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <topic-description> [ai-assistant]"
    echo "Example: $0 bug-fixes cursor"
    echo "Example: $0 new-features chatgpt"
    exit 1
fi

# Get current date and topic
DATE=$(date +%Y-%m-%d)
TOPIC=$(echo "$1" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
AI_ASSISTANT=${2:-"cursor"}

# Create filename
FILENAME="docs/chats/${DATE}_${TOPIC}.md"

# Create the file with template
cat > "$FILENAME" << EOF
# ${TOPIC^} - $(date +"%B %d, %Y")

**AI Assistant:** ${AI_ASSISTANT^}
**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Topic:** ${1}

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

<!-- Paste the exported chat content below this line -->

EOF

echo "✅ Created chat log: $FILENAME"
echo "📝 Opening in editor for you to paste the chat content..."

# Open in default editor (or VS Code if available)
if command -v code &> /dev/null; then
    code "$FILENAME"
elif command -v vim &> /dev/null; then
    vim "$FILENAME"
else
    echo "Please open $FILENAME in your preferred editor and paste the chat content"
fi

# Remind user to update the index
echo ""
echo "📋 Don't forget to update docs/chats/README.md with this new entry!"
echo "   Add this line to the Chat Index table:"
echo "   | $(date +%Y-%m-%d) | [${DATE}_${TOPIC}.md](./${DATE}_${TOPIC}.md) | ${1} | ${AI_ASSISTANT^} | <!-- Add key outcomes --> |" 