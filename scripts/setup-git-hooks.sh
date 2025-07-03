#!/bin/bash

# Setup script to install git hooks for the ke-custom project
# This ensures all contributors use the same development workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 Setting up git hooks for ke-custom project...${NC}"
echo

# Check if we're in the right directory
if [ ! -f "karabiner.json" ] || [ ! -d "docs/chats" ]; then
    echo -e "${RED}❌ Error: Please run this script from the ke-custom project root directory${NC}"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy the pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Pre-commit hook to encourage chat history documentation
# Checks if chat history files are being added, prompts for confirmation if not

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    exit 1
fi

# Get list of staged files
staged_files=$(git diff --cached --name-only)

# Check if any chat history files are being added
chat_files=$(echo "$staged_files" | grep "^docs/chats/.*\.md$" | grep -v "docs/chats/README.md")

# Check if there are any code changes (karabiner.json, scripts, etc.)
code_changes=$(echo "$staged_files" | grep -E "\.(json|sh|md)$" | grep -v "^docs/chats/")

if [ -n "$code_changes" ]; then
    echo -e "${BLUE}📝 Code changes detected:${NC}"
    echo "$code_changes" | sed 's/^/  • /'
    echo
    
    if [ -n "$chat_files" ]; then
        echo -e "${GREEN}✅ Chat history found:${NC}"
        echo "$chat_files" | sed 's/^/  • /'
        echo -e "${GREEN}Great! Development session properly documented.${NC}"
        echo
    else
        echo -e "${YELLOW}⚠️  No chat history detected in this commit.${NC}"
        echo
        echo -e "${BLUE}It's recommended to document development sessions by:${NC}"
        echo "  1. Export chat from Cursor (⋮ → Export Chat)"
        echo "  2. Save to docs/chats/exported/"
        echo "  3. Run: ./scripts/add-chat-log.sh"
        echo "  4. Add the generated file to your commit"
        echo
        echo -e "${YELLOW}Do you want to proceed without chat history? (y/N)${NC}"
        
        # Read user input
        read -r response < /dev/tty
        
        case "$response" in
            [yY]|[yY][eE][sS])
                echo -e "${GREEN}✅ Proceeding without chat history...${NC}"
                ;;
            *)
                echo -e "${RED}❌ Commit aborted. Please add chat history and try again.${NC}"
                echo
                echo -e "${BLUE}Quick workflow:${NC}"
                echo "  1. Export chat: Cursor → ⋮ → Export Chat → Save to docs/chats/exported/"
                echo "  2. Process: ./scripts/add-chat-log.sh"
                echo "  3. Stage: git add docs/chats/[new-file].md"
                echo "  4. Commit: git commit"
                exit 1
                ;;
        esac
    fi
else
    # No code changes, just documentation or other files
    if [ -n "$chat_files" ]; then
        echo -e "${GREEN}📚 Adding chat history documentation.${NC}"
    fi
fi

# Check if karabiner.json was modified and README was updated
karabiner_modified=$(echo "$staged_files" | grep "^karabiner\.json$")
readme_modified=$(echo "$staged_files" | grep "^README\.md$")

if [ -n "$karabiner_modified" ] && [ -z "$readme_modified" ]; then
    echo -e "${RED}⚠️  WARNING: karabiner.json modified but README.md not updated!${NC}"
    echo -e "${YELLOW}The README should be updated to reflect configuration changes.${NC}"
    echo
    echo -e "${YELLOW}Do you want to proceed anyway? (y/N)${NC}"
    
    read -r response < /dev/tty
    
    case "$response" in
        [yY]|[yY][eE][sS])
            echo -e "${YELLOW}⚠️  Proceeding with karabiner.json changes but no README update...${NC}"
            ;;
        *)
            echo -e "${RED}❌ Commit aborted. Please update README.md and try again.${NC}"
            exit 1
            ;;
    esac
fi

echo -e "${GREEN}🚀 All checks passed. Proceeding with commit...${NC}"
exit 0
EOF

# Make the hook executable
chmod +x .git/hooks/pre-commit

echo -e "${GREEN}✅ Pre-commit hook installed successfully!${NC}"
echo
echo -e "${BLUE}What the hook does:${NC}"
echo "  • Checks for chat history when committing code changes"
echo "  • Prompts for confirmation if no chat history is found"
echo "  • Verifies README updates when karabiner.json is modified"
echo "  • Provides helpful workflow reminders"
echo
echo -e "${GREEN}🎉 Git hooks setup complete! Your commits will now encourage proper documentation.${NC}" 