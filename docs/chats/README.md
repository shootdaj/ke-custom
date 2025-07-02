# Development Chat Logs

This directory contains exported conversations from AI development sessions for the ke-custom project.

## Chat Index

| Date | Filename | Topic | AI Assistant | Key Outcomes |
|------|----------|--------|--------------|---------------|
| 2025-01-07 | [2025-01-07_initial-development.md](./2025-01-07_initial-development.md) | Initial Karabiner Elements configuration creation | Cursor/Claude | Complete Windows-to-Mac keyboard mapping system, GitHub repo setup |

## Naming Convention

Use the following format for chat log filenames:
```
YYYY-MM-DD_topic-description.md
```

Examples:
- `2025-01-07_initial-development.md`
- `2025-01-08_bug-fixes.md`
- `2025-01-10_feature-additions.md`
- `2025-01-15_performance-optimization.md`

## What to Include

For each chat session, consider documenting:

### 📋 Essential Information
- **Date and time** of the conversation
- **AI assistant used** (Cursor, ChatGPT, Claude, etc.)
- **Main topic/goal** of the session
- **Key decisions made**
- **Code changes implemented**
- **Issues encountered and solutions**

### 🔗 Cross-References
- Link to relevant commits: `git log --oneline --since="2025-01-07" --until="2025-01-08"`
- Reference related files or documentation
- Link to GitHub issues or PRs if applicable

### 📝 Context for Future Sessions
- **Outstanding questions** or TODO items
- **Ideas for future improvements**
- **Technical debt or limitations noted**
- **User feedback or testing results**

## Export Tips

### From Cursor
1. Open the chat panel
2. Click the export button (usually three dots menu)
3. Choose "Export as Markdown"
4. Save with the naming convention above

### From ChatGPT
1. Click the three dots next to the conversation title
2. Select "Export"
3. Choose your preferred format (Markdown recommended)
4. Rename according to convention

### From Claude (web)
1. Use browser extension or manual copy
2. Format as markdown with proper headers
3. Include timestamp and context

## Automation Ideas

### Git Integration
Add a git hook to automatically timestamp major changes:
```bash
#!/bin/bash
# In .git/hooks/post-commit
echo "$(date): $(git log -1 --pretty=format:'%s')" >> docs/chats/commit-log.txt
```

### Chat Export Script
Create a script to help with consistent exports:
```bash
#!/bin/bash
# chat-export.sh
DATE=$(date +%Y-%m-%d)
TOPIC=$1
FILENAME="docs/chats/${DATE}_${TOPIC}.md"
echo "Creating chat log: $FILENAME"
touch "$FILENAME"
# Open in editor for manual paste
code "$FILENAME"
```

## Best Practices

1. **Export regularly** - Don't wait until sessions are too long
2. **Add context** - Include brief summaries of what was accomplished
3. **Link related items** - Connect chats to commits, issues, documentation
4. **Clean up exports** - Remove unnecessary system messages or formatting artifacts
5. **Update the index** - Keep the table above current
6. **Backup important insights** - Extract key decisions into permanent documentation

## Search and Reference

To search across all chats:
```bash
# Search for specific topics
grep -r "terminal shortcuts" docs/chats/

# Find chats about specific files
grep -r "karabiner.json" docs/chats/

# List recent chats
ls -la docs/chats/*.md | head -10
```

---

*This system helps maintain continuity across development sessions and provides valuable context for future AI collaborations.* 