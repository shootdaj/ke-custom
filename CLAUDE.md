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

### 2. Deployment Workflow

Simple backup → deploy → test → keep or revert:

**Deploy:**
```bash
./scripts/deploy.sh
```
- Backs up current live config to `~/.config/karabiner/karabiner.json.backup`
- Copies `karabiner.json` to live config
- Restarts Karabiner Elements

**Revert (if test fails):**
```bash
./scripts/revert.sh
```
- Restores from backup
- Restarts Karabiner Elements

That's it. No profiles, no ceremony.

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

**Deploy configuration:**
```bash
./scripts/deploy.sh
```

**Revert to previous config:**
```bash
./scripts/revert.sh
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

- **`karabiner.json`** - The configuration file with all keyboard mappings
- **`btt/btt-preset.bttpreset`** - BetterTouchTool configuration
- **`README.md`** - User-facing documentation (MUST stay in sync with karabiner.json)

### Documentation

- **`docs/karabiner-technical-learnings.md`** - Technical insights and Karabiner rule processing fundamentals

### Scripts

- **`scripts/deploy.sh`** - Backup current Karabiner config and deploy new one
- **`scripts/revert.sh`** - Restore previous Karabiner config from backup
- **`scripts/btt-export.sh`** - Export BetterTouchTool config to repo
- **`scripts/btt-import.sh`** - Import BetterTouchTool config on new machine

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
4. Deploy with `./scripts/deploy.sh`
5. Test - if it fails, run `./scripts/revert.sh`
6. Update `README.md` to document the mapping

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
