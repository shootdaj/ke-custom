# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Karabiner Elements configuration** that transforms a MacBook keyboard to behave like a Windows keyboard. The core file is `karabiner.json`, which contains complex keyboard mappings that make Mac modifier keys mimic Windows behavior.

**Key transformation:**
- `fn` key → Windows Ctrl (Mac Command)
- `Cmd` key → Windows Alt (Mac Option)
- `Left Option` key → Windows Meta/Super
- `Right Option` key → Windows Ctrl for navigation
- `Control` key → Windows Fn for navigation

## Critical Development Rules

### 1. Documentation Synchronization (CRITICAL)
**Whenever `karabiner.json` is modified, you MUST update `README.md`** to reflect those changes. This includes:
- New key mappings or shortcuts
- Modified keyboard behavior
- Changes to terminal-specific behavior
- Any configuration modifications

The README must accurately document all functionality present in the karabiner.json configuration.

### 2. Deployment Workflow (CRITICAL)

This project uses a **multi-profile system** that NEVER overwrites configurations:

**Test Deployments** (experimentation/iteration):
```bash
./scripts/deploy-test.sh
```
- Creates draft profiles with "| Draft" suffix
- For testing and iteration only
- Does NOT update version history
- Can deploy multiple times without ceremony

**Final Deployments** (production):
```bash
./scripts/deploy-final.sh
```
- Creates timestamped profile: "WinKeyMap: YYYY-MM-DD HH:MM:SS"
- Updates `karabiner.final.json`
- Restarts Karabiner Elements automatically
- Ready for version history documentation

**Version History Documentation**:
When user says "build-version-history":
1. Analyze changes between previous and current final versions
2. Generate human-readable change summary
3. Update `docs/version-history.md` with changes, functionality impact, and testing notes
4. Update `README.md` if needed

### 3. Karabiner Configuration Rules

**Rule Processing Order** (CRITICAL):
- Karabiner processes rules **TOP-TO-BOTTOM, FIRST MATCH WINS**
- Once a rule matches, processing stops
- **Specific combinations MUST be placed before general transformations**
- Rule priority sections:
  1. Special cases (highest priority)
  2. Navigation shortcuts
  3. Alphabet/number/symbol mappings
  4. General modifier transformations (lowest priority)

**Caps Lock Compatibility** (CRITICAL):
- **ALL modifier key mappings must include `"optional": ["caps_lock"]`**
- This fixes Karabiner Elements 15.1.0+ Caps Lock handling
- Without this, mappings fail when Caps Lock is active
- Always test functionality with both Caps Lock ON and OFF

Example:
```json
{
  "from": {
    "key_code": "a",
    "modifiers": {
      "mandatory": ["fn"],
      "optional": ["caps_lock"]  // Required for Caps Lock compatibility
    }
  },
  "to": [...]
}
```

**Common Pitfalls**:
- Avoid overly broad modifier matching with `"optional": ["any"]`
- These rules can intercept specific combinations before they're processed
- Place specific combination rules in higher priority sections

## Development Commands

**Deploy test configuration:**
```bash
./scripts/deploy-test.sh
```

**Deploy final configuration:**
```bash
./scripts/deploy-final.sh
```

**Setup git hooks** (for contributors):
```bash
./scripts/setup-git-hooks.sh
```

**Find app bundle identifiers** (for adding app-specific rules):
```bash
# For running apps
osascript -e 'id of app "AppName"'

# For installed apps
mdls -name kMDItemCFBundleIdentifier -r /Applications/AppName.app
```

**Restart Karabiner Elements:**
```bash
osascript -e 'quit app "Karabiner-Elements"' && sleep 2 && open -a "Karabiner-Elements"
```

## Project Architecture

### Core Files

- **`karabiner.json`** - Working configuration file with all keyboard mappings
- **`karabiner.final.json`** - Production configuration with all deployed profiles
- **`README.md`** - User-facing documentation (MUST stay in sync with karabiner.json)
- **`.cursorrules`** - Development workflow rules and requirements

### Documentation Structure

- **`docs/karabiner-technical-learnings.md`** - Technical insights, best practices, Karabiner rule processing fundamentals
- **`docs/version-history.md`** - Change tracking for all deployed profiles
- **`docs/karabiner-elements-plan.md`** - Development plan and specifications
- **`docs/tab-switching-progress-report.md`** - Implementation history (reference for past attempts)
- **`docs/chats/`** - AI development session logs for context

### Scripts

- **`scripts/deploy-test.sh`** - Deploy draft profiles for testing
- **`scripts/deploy-final.sh`** - Deploy production profiles with timestamps
- **`scripts/add-chat-log.sh`** - Add development session logs
- **`scripts/setup-git-hooks.sh`** - Install git hooks for documentation workflow

## Configuration Structure

The `karabiner.json` file contains:

1. **System toggle controls** - Enable/disable Windows mapping (fn+Ctrl+Opt+Cmd+E/D)
2. **Special cases** (highest priority) - fn+Tab, fn+Backspace, etc.
3. **Terminal-specific mappings** - Different behavior in Terminal.app/Warp
4. **Alphabet mappings** (A-Z) - fn+letter combinations
5. **Number mappings** (0-9) - Tab switching, etc.
6. **Symbol mappings** (punctuation) - Zoom, preferences, etc.
7. **Arrow key navigation** - Word skipping, page navigation, document start/end
8. **General modifier transformations** (lowest priority)

### Context-Aware Behavior

Rules can be app-specific using `bundle_identifiers`:
```json
{
  "conditions": [
    {
      "bundle_identifiers": ["com.apple.Terminal", "dev.warp.Warp-Stable"],
      "type": "frontmost_application_if"
    }
  ],
  ...
}
```

## Testing Checklist

When modifying configurations:
1. Test in regular applications (TextEdit, browser)
2. Test in terminal applications (Terminal.app, Warp)
3. Verify toggle functionality (fn+Ctrl+Opt+Cmd+E/D)
4. Check shift variant combinations
5. **Test with Caps Lock both ON and OFF**
6. Ensure no conflicts with existing shortcuts

## Profile Management

- **27+ historical profiles** available in Karabiner Elements UI
- Switch profiles in UI dropdown for instant rollback
- Git history provides reliable profile creation
- All changes documented in `docs/version-history.md`

## Key Technical Insights

1. **First match wins** - Rule order determines behavior
2. **Specific before general** - Prevent interference from broad rules
3. **Caps Lock compatibility** - Always include as optional modifier
4. **Context awareness** - Use bundle identifiers for app-specific behavior
5. **Simple is better** - Avoid complex state management when possible

## Common Tasks

**Adding a new keyboard mapping:**
1. Determine priority level (where in rule order?)
2. Add to appropriate section in `karabiner.json`
3. Include `"optional": ["caps_lock"]` in modifiers
4. Test with Caps Lock ON and OFF
5. Update `README.md` to document the mapping
6. Deploy with `./scripts/deploy-test.sh` first
7. After testing, deploy with `./scripts/deploy-final.sh`
8. Run "build-version-history" to document changes

**Adding app-specific behavior:**
1. Get bundle identifier using osascript or mdls
2. Add to `bundle_identifiers` condition array
3. Test in target application
4. Update documentation

**Debugging a mapping issue:**
1. Check rule priority order
2. Look for interfering broader rules
3. Verify Caps Lock compatibility
4. Test in isolation (disable other rules temporarily)
5. Consult `docs/karabiner-technical-learnings.md`
