# Karabiner Elements Configuration Plan: Windows-to-Mac Keyboard Mapping

## Project Overview
Create a Karabiner Elements configuration that allows Windows keyboard usage patterns on MacBook, primarily by remapping the `fn` key to act as Windows Ctrl, along with other modifier key remappings.

## Key Mapping Strategy

### Primary Modifier Mappings
| Mac Key | Windows Equivalent | Mac Action |
|---------|-------------------|------------|
| `fn` | Windows Ctrl | Mac `Command` (with exceptions) |
| `Cmd` | Windows Alt | Mac `Option` |
| Left `Option` | Windows Meta/Super | Mac `Command` (for window management) |
| `Control` | Windows Fn | Mac `Control` (for word navigation) |
| Right `Option` | Right Windows Ctrl | Mac `Command` |
| Right `Cmd` | Right Windows Alt | Mac `Option` |

### Exception Handling for fn Key

#### 1. Function Keys (F1-F12)
- **Rule**: `fn + F1-F12` → Keep native Mac behavior
- **Reason**: Preserve brightness, volume, media controls
- **Implementation**: Exclude F1-F12 from fn remapping

#### 2. Tab Key
- **Rule**: `fn + Tab` → Mac `Control + Tab`
- **Reason**: Tab switching in browsers/apps (Windows Ctrl+Tab equivalent)
- **Implementation**: Specific mapping for fn+Tab combination

#### 3. Terminal Applications (Terminal.app & Warp)
- **Rule**: `fn + C` → Mac `Control + C`
- **Reason**: Kill running processes (Windows Ctrl+C equivalent)
- **Implementation**: Application-specific rule for terminal apps
- **Additional**: Consider `fn + D` → `Control + D` (EOF), `fn + Z` → `Control + Z` (suspend)

## Detailed Key Combinations

### Core Productivity Shortcuts (fn-based)
```
fn + C → Command + C (copy) | Control + C (in terminals)
fn + V → Command + V (paste)
fn + X → Command + X (cut)
fn + Z → Command + Z (undo)
fn + Y → Command + Y (redo)
fn + A → Command + A (select all)
fn + S → Command + S (save)
fn + N → Command + N (new)
fn + O → Command + O (open)
fn + F → Command + F (find)
fn + W → Command + W (close tab/window)
fn + T → Command + T (new tab)
fn + Shift + T → Command + Shift + T (reopen tab)
fn + Tab → Control + Tab (switch tabs)
fn + Shift + Tab → Control + Shift + Tab (reverse tab switch)
```

### Window Management (Left Option-based)
```
Left Option + Left Arrow → Window snap left
Left Option + Right Arrow → Window snap right
Left Option + Up Arrow → Window maximize
Left Option + Down Arrow → Window minimize
```
**Note**: Keep existing BetterTouchTool mappings, ensure no conflicts

### Navigation (Control-based)
```
Control + Left Arrow → Option + Left Arrow (word skip left)
Control + Right Arrow → Option + Right Arrow (word skip right)
Control + Up Arrow → Page Up
Control + Down Arrow → Page Down
fn + Control + Left Arrow → Command + Left Arrow (document start)
fn + Control + Right Arrow → Command + Right Arrow (document end)
```

## Application-Specific Rules

### Terminal Applications
- **Target Apps**: Terminal.app, Warp
- **Special Rules**:
  - `fn + C` → `Control + C` (kill process)
  - `fn + D` → `Control + D` (EOF)
  - `fn + Z` → `Control + Z` (suspend)
  - `fn + L` → `Control + L` (clear screen)

### Web Browsers
- **Target Apps**: Chrome, Firefox, Safari, Edge
- **Special Rules**:
  - `fn + Tab` → `Control + Tab` (next tab)
  - `fn + Shift + Tab` → `Control + Shift + Tab` (previous tab)
  - `fn + Number` → `Command + Number` (tab selection)

### Text Editors/IDEs
- **Target Apps**: VS Code, Sublime Text, etc.
- **Special Rules**:
  - `fn + /` → `Command + /` (comment toggle)
  - `fn + D` → `Command + D` (duplicate line)
  - `fn + Shift + K` → `Command + Shift + K` (delete line)

## System Toggle Controls

### Enable/Disable Mappings
- **Enable**: `fn + Control + Option + Command + E`
- **Disable**: `fn + Control + Option + Command + D`
- **Implementation**: Complex modification with variable state

## Technical Implementation Details

### Karabiner Elements Structure
1. **Complex Modifications**: For conditional logic and application-specific rules
2. **Variables**: To track enable/disable state
3. **Conditions**: Application frontmost, keyboard type detection
4. **Manipulators**: Key mapping rules with proper modifier handling

### Rule Priority
1. Application-specific exceptions (highest priority)
2. Key combination exceptions (fn + F1-F12, fn + Tab)
3. General modifier mappings (lowest priority)

### Potential Conflicts & Solutions

#### Conflict 1: Right Option Mapping
- **Issue**: Right Option mapped to both Windows Meta and Right Control
- **Solution**: Clarify intended behavior - suggest Right Option → Right Control for consistency

#### Conflict 2: BetterTouchTool Integration
- **Issue**: Window snapping already handled by BTT
- **Solution**: Either disable BTT window snapping or modify Option key to work with BTT

#### Conflict 3: System Shortcuts
- **Issue**: Some Mac system shortcuts might conflict
- **Solution**: Create exclusion rules for critical system functions

## Testing Strategy

### Phase 1: Basic Modifier Testing
- Test each modifier key individually
- Verify no system shortcuts are broken
- Test in simple applications (TextEdit, Notes)

### Phase 2: Application-Specific Testing
- Test terminal behavior thoroughly
- Verify browser tab switching
- Test text editor shortcuts

### Phase 3: Complex Combinations
- Test multiple modifier combinations
- Verify toggle functionality
- Test under different system states

## File Structure

```
karabiner-config/
├── karabiner.json (main configuration)
├── rules/
│   ├── basic-modifiers.json
│   ├── terminal-exceptions.json
│   ├── browser-specific.json
│   └── system-toggles.json
└── README.md (usage instructions)
```

## Clarifications Resolved

1. **Right Option Mapping**: ✅ Both Option keys act as Windows Meta for window management
2. **BetterTouchTool Integration**: ✅ Modify underlying key, BTT will be updated accordingly  
3. **System Shortcuts**: ✅ No Mac system shortcuts need preservation initially
4. **Gaming Mode**: ✅ Not needed
5. **External Keyboards**: ✅ Not needed initially

## Developer-Specific Requirements

### Primary Code Editors
- **VSCode** and **Cursor** (priority)
- **General editors** (secondary, no custom mapping unless needed)

### Critical Coding Shortcuts
- **Word skipping**: Control + Left/Right Arrow → Option + Left/Right Arrow
- **Line navigation**: fn + Control + Left/Right → Command + Left/Right
- **Page navigation**: Control + Up/Down → Page Up/Down
- **Document navigation**: fn + Control + Up/Down → Command + Up/Down
- **Selection**: All above + Shift modifier combinations

## Current Status (Updated 2025-01-07)

### ✅ **Completed Implementation**
- **Core modifier mappings**: All fn key combinations implemented
- **Application-specific rules**: Terminal and browser support working
- **Toggle functionality**: Enable/disable system implemented
- **Caps Lock compatibility**: All mappings work with Caps Lock in any state
- **Multi-profile deployment**: Automated deployment system with version history
- **Simplified tab switching**: Reliable Control+Tab mapping adopted

### ✅ **Deployment System**
- **Test deployments**: `./scripts/deploy-test.sh` for experimentation
- **Final deployments**: `./scripts/deploy-final.sh` for production
- **Version tracking**: Automated change documentation in `docs/version-history.md`
- **Profile management**: Git-based historical profiles with instant rollback

### ✅ **Documentation**
- **Complete README**: Installation, usage, and troubleshooting guide
- **Version history**: Detailed change tracking with human-readable summaries
- **Technical learnings**: Best practices and implementation insights
- **Current issues**: Active problem tracking and investigation

### 🔄 **Current Focus**
- **Issue resolution**: Addressing current problems (BTT conflicts, right option mapping)
- **Testing and refinement**: Ensuring reliability across all applications
- **Documentation maintenance**: Keeping all docs synchronized with implementation

## Next Steps

1. ✅ **Resolve current issues** (see `docs/current-issues.md`)
2. ✅ **Maintain documentation** synchronization
3. ✅ **Continue testing** and refinement
4. ✅ **Monitor for new requirements** or edge cases

This plan has been successfully implemented and is now in maintenance mode with ongoing improvements and issue resolution. 