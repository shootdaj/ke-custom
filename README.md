# Windows-to-Mac Keyboard Mapping for Karabiner Elements

Transform your MacBook keyboard to behave like a Windows keyboard, making it easier to use your Windows muscle memory on Mac.

## Overview

This Karabiner Elements configuration remaps your MacBook's modifier keys to mimic Windows keyboard behavior:

- **`fn` key** → Acts as **Windows Ctrl** (Mac Command) for ALL shortcuts
- **`Cmd` key** → Acts as **Windows Alt** (Mac Option) 
- **`Left Option` key** → Acts as **Windows Meta/Super** (Mac Command) for window management
- **`Right Option` key** → Acts as **Windows Ctrl** for navigation (word skipping, backspace)
- **`Control` key** → Acts as **Windows Fn** for navigation (line start/end, page up/down)

## Key Features

### ✅ **COMPLETE Keyboard Coverage**
**Every** key now works with the `fn` modifier - no exceptions:
- **All 26 alphabet keys** (A-Z) with `fn` modifier
- **All 10 number keys** (0-9) with `fn` modifier  
- **All 12 symbol keys** (- = [ ] \ ; ' , . / `) with `fn` modifier
- **All shift combinations** automatically supported

### ✅ **Smart Context-Aware Behavior**
- **Regular apps**: `fn + key` → `Command + key` (standard Mac shortcuts)
- **Terminals**: `fn + key` → `Control + key` (proper shell commands)
- **Automatic detection** of Terminal.app and Warp

### ✅ **Complete Alphabet Mappings**
Every letter key works as expected:
```
fn + A → Select All       fn + N → New Document
fn + B → Bold Text        fn + O → Open File  
fn + C → Copy            fn + P → Print
fn + D → Duplicate       fn + Q → Quit App
fn + E → Find Selection   fn + R → Reload/Refresh
fn + F → Find            fn + S → Save
fn + G → Find Next       fn + T → New Tab
fn + H → Hide/Replace    fn + U → Underline
fn + I → Italic          fn + V → Paste
fn + J → Jump Selection  fn + W → Close Tab
fn + K → Add Link        fn + X → Cut
fn + L → Location Bar    fn + Y → Redo
fn + M → Minimize        fn + Z → Undo
```

### ✅ **Number Key Mappings**
Perfect for tab switching and bookmarks:
```
fn + 1 → Command + 1 (Tab 1)
fn + 2 → Command + 2 (Tab 2)
...
fn + 9 → Command + 9 (Tab 9)
fn + 0 → Command + 0 (Tab 10)
```

### ✅ **Symbol Key Mappings**
All punctuation and symbols covered:
```
fn + - → Zoom Out         fn + ; → Spell Check
fn + = → Zoom In          fn + ' → Cycle Windows
fn + [ → Back/Outdent     fn + , → Preferences
fn + ] → Forward/Indent   fn + . → Cancel/Stop
fn + \ → Various Uses     fn + / → Help/Comment
fn + ` → Cycle App Windows
```

### ✅ **Comprehensive Terminal Support**
Enhanced shell command support in Terminal.app and Warp:
```
fn + A → Ctrl + A (beginning of line)
fn + C → Ctrl + C (kill process) 
fn + D → Ctrl + D (EOF)
fn + E → Ctrl + E (end of line)
fn + F → Ctrl + F (forward character)
fn + K → Ctrl + K (kill line)
fn + L → Ctrl + L (clear screen)
fn + N → Ctrl + N (next command)
fn + P → Ctrl + P (previous command)
fn + R → Ctrl + R (reverse search)
fn + U → Ctrl + U (kill line backward)
fn + Z → Ctrl + Z (suspend process)
```

**All terminal shortcuts work with Caps Lock in any state (ON or OFF).**

### ✅ **Developer Navigation (Perfect for VSCode/Cursor)**
- `fn + Left/Right Arrow` → Word skipping
- `fn + Shift + Left/Right Arrow` → Word selection
- `Right Option + Left/Right Arrow` → Word skipping
- `Right Option + Shift + Left/Right Arrow` → Word selection
- `Option + Backspace` → Ctrl+W in Warp (tmux word-delete)
- `fn + Backspace` → Delete previous word
- `Right Option + Backspace` → Delete previous word
- `Control + Backspace` → Delete character forward (like Windows Delete key)
- `Control + fn + Backspace` → Delete word forward
- `Control + Left/Right Arrow` → Line start/end
- `Control + Shift + Left/Right Arrow` → Line start/end with selection
- `Control + Up/Down Arrow` → Page up/down
- `Control + Shift + Up/Down Arrow` → Page up/down with selection
- `fn + Control + Left/Right Arrow` → Document start/end
- `fn + Control + Shift + Left/Right Arrow` → Document start/end with selection

**All navigation shortcuts work with Caps Lock in any state (ON or OFF).**



### ✅ **Shift Variant Support**
Every mapping automatically supports shift combinations:
- `fn + Shift + T` → `Command + Shift + T` (reopen closed tab)
- `fn + Shift + Z` → `Command + Shift + Z` (redo)
- `fn + Shift + [number]` → `Command + Shift + [number]`
- And hundreds more combinations

**All shift combinations work with Caps Lock in any state (ON or OFF).**

### ✅ **Function Keys Preserved**
- `fn + F1-F12` → Keep native Mac behavior (brightness, volume, etc.)

### ✅ **Default macOS Page Up/Down Override**
- `fn + Up Arrow` → **Up Arrow** (prevents default macOS Page Up behavior)
- `fn + Down Arrow` → **Down Arrow** (prevents default macOS Page Down behavior)
- This prevents accidental page scrolling when using fn key combinations

### ✅ **Window Management Ready**
- Option keys work as Windows Meta key for window snapping
- Compatible with BetterTouchTool and other window managers

## Installation

### Prerequisites
1. Install [Karabiner Elements](https://karabiner-elements.pqrs.org/)
2. Grant necessary permissions in System Preferences

### Setup
1. **Backup existing configuration** (if you have one):
   ```bash
   cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.backup
   ```

2. **Install the configuration**:
   ```bash
   # Copy the karabiner.json to your Karabiner config directory
   cp karabiner.json ~/.config/karabiner/karabiner.json
   ```

3. **Restart Karabiner Elements** or reload the configuration:
   - Open Karabiner Elements
   - The "Windows-to-Mac Keyboard Mapping" profile should be active

### BetterTouchTool Setup (Optional)

This repo also includes BetterTouchTool configuration for window management and additional shortcuts.

1. **Install BetterTouchTool** from [folivora.ai](https://folivora.ai/)

2. **Import the preset** (choose one):

   **Option A - Clean import (replaces everything):**
   ```bash
   ./scripts/btt-clean-import.sh
   ```
   ⚠️ This DELETES all existing BTT config first. Use for fresh setup.

   **Option B - Add to existing config:**
   ```bash
   ./scripts/btt-import.sh
   ```
   This adds to your existing BTT config (may cause duplicates).

3. **To save your BTT changes back to the repo**:
   ```bash
   ./scripts/btt-export.sh
   ```

## Usage

### Toggle On/Off
- **Enable**: `fn + Control + Option + Command + E`
- **Disable**: `fn + Control + Option + Command + D`

You'll see a notification when toggling the mapping on/off.

**Note**: Toggle controls work with Caps Lock in any state (ON or OFF).

### BetterTouchTool Integration
To avoid collisions with fn-based word navigation:
- `fn + Left/Right` emits `Right Option + Left/Right` (word navigation)
- Bind BTT Back/Forward triggers to `Left Option + Left/Right` only
- Ensure BTT shortcuts are recorded with the left Option key specifically (not “any Option”)
- Remove any generic `Option + Arrow` triggers

This keeps universal Back/Forward on Command (remapped to Left Option) while fn-based word navigation remains unaffected and uses macOS’s native key repeat.

## Complete Shortcuts Reference

### **Core Productivity (Works Everywhere)**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + A` | `fn + A` | Select All |
| `Ctrl + C` | `fn + C` | Copy |
| `Ctrl + V` | `fn + V` | Paste |
| `Ctrl + X` | `fn + X` | Cut |
| `Ctrl + Z` | `fn + Z` | Undo |
| `Ctrl + Y` | `fn + Y` | Redo |
| `Ctrl + S` | `fn + S` | Save |
| `Ctrl + N` | `fn + N` | New |
| `Ctrl + O` | `fn + O` | Open |
| `Ctrl + F` | `fn + F` | Find |
| `Ctrl + G` | `fn + G` | Find Next |
| `Ctrl + H` | `fn + H` | Replace |
| `Ctrl + P` | `fn + P` | Print |
| `Ctrl + Q` | `fn + Q` | Quit |

### **Text Formatting**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + B` | `fn + B` | Bold |
| `Ctrl + I` | `fn + I` | Italic |
| `Ctrl + U` | `fn + U` | Underline |

### **Browser/App Navigation**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + W` | `fn + W` | Close tab |
| `Ctrl + T` | `fn + T` | New tab |
| `Ctrl + Shift + T` | `fn + Shift + T` | Reopen tab |
| `Ctrl + L` | `fn + L` | Address bar |
| `Ctrl + R` | `fn + R` | Reload |
| `Ctrl + D` | `fn + D` | Bookmark |
| `Ctrl + 1-9` | `fn + 1-9` | Switch to tab |
| `Ctrl + 0` | `fn + 0` | Switch to tab 10 |

### **Zoom & View Controls**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + -` | `fn + -` | Zoom out |
| `Ctrl + =` | `fn + =` | Zoom in |
| `Ctrl + ,` | `fn + ,` | Preferences |

### **Navigation (Perfect for Coding)**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + Left` | `fn + Left` | Word skip left |
| `Ctrl + Right` | `fn + Right` | Word skip right |
| `Ctrl + Left` | `Right Option + Left` | Word skip left |
| `Ctrl + Right` | `Right Option + Right` | Word skip right |
| `Ctrl + Backspace` | `fn + Backspace` | Delete previous word |
| `Ctrl + Backspace` | `Right Option + Backspace` | Delete previous word |
| `Delete` | `Control + Backspace` | Delete character forward |
| `Ctrl + Delete` | `Control + fn + Backspace` | Delete word forward |
| `Home` | `Control + Left` | Line start |
| `End` | `Control + Right` | Line end |
| `Ctrl + Home` | `fn + Control + Left` | Document start |
| `Ctrl + End` | `fn + Control + Right` | Document end |
| `Page Up` | `Control + Up` | Page up |
| `Page Down` | `Control + Down` | Page down |
| `Ctrl + Shift + Left` | `fn + Shift + Left` | Select word left |
| `Ctrl + Shift + Right` | `fn + Shift + Right` | Select word right |
| `Ctrl + Shift + Left` | `Right Option + Shift + Left` | Select word left |
| `Ctrl + Shift + Right` | `Right Option + Shift + Right` | Select word right |
| `Shift + Home` | `Control + Shift + Left` | Select to line start |
| `Shift + End` | `Control + Shift + Right` | Select to line end |
| `Ctrl + Shift + Home` | `fn + Control + Shift + Left` | Select to document start |
| `Ctrl + Shift + End` | `fn + Control + Shift + Right` | Select to document end |
| `Shift + Page Up` | `Control + Shift + Up` | Select page up |
| `Shift + Page Down` | `Control + Shift + Down` | Select page down |

### **Code/Text Editing**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + [` | `fn + [` | Outdent |
| `Ctrl + ]` | `fn + ]` | Indent |
| `Ctrl + /` | `fn + /` | Comment toggle |
| `Ctrl + K` | `fn + K` | Add link/Clear |

### **Terminal & Shell Commands**
| Windows Shortcut | Mac Keys (in Terminal) | Result |
|------------------|-------------------------|---------|
| `Ctrl + A` | `fn + A` | Beginning of line |
| `Ctrl + E` | `fn + E` | End of line |
| `Ctrl + C` | `fn + C` | Kill process |
| `Ctrl + D` | `fn + D` | EOF |
| `Ctrl + Z` | `fn + Z` | Suspend |
| `Ctrl + L` | `fn + L` | Clear screen |
| `Ctrl + R` | `fn + R` | Reverse search |
| `Ctrl + P` | `fn + P` | Previous command |
| `Ctrl + N` | `fn + N` | Next command |
| `Ctrl + K` | `fn + K` | Kill line |
| `Ctrl + U` | `fn + U` | Kill line backward |
| `Ctrl + F` | `fn + F` | Forward character |

### **Window Management**
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Alt + Tab` | `Cmd + Tab` | App switcher |
| `Alt + F4` | `fn + Q` | Quit app |
| `Alt + Space` | `fn + '` | Window menu |
| `Win + M` | `fn + M` | Minimize |

## Troubleshooting

### Configuration Not Loading
1. Check Karabiner Elements is running
2. Verify permissions in System Preferences → Security & Privacy
3. Restart Karabiner Elements
4. Check the configuration file location: `~/.config/karabiner/karabiner.json`

### Shortcuts Not Working in Specific Apps
1. Check if the app requires additional permissions
2. Some apps may override keyboard shortcuts - check app preferences
3. Try toggling the mapping off and on again

### Function Keys Not Working
- Function keys (F1-F12) should work normally with `fn` modifier
- If not working, check System Preferences → Keyboard → "Use F1, F2, etc. keys as standard function keys"

### fn + Up/Down Arrow Not Working
- `fn + Up Arrow` and `fn + Down Arrow` now send regular Up/Down Arrow commands instead of default macOS Page Up/Page Down behavior
- If you need page scrolling, use `Control + Up Arrow` (Page Up) and `Control + Down Arrow` (Page Down) instead
- This prevents accidental page scrolling when using fn key combinations

### Caps Lock LED Not Working
- The configuration includes proper Caps Lock LED control (`manipulate_caps_lock_led: true`)
- This ensures the Caps Lock indicator light functions normally
- The fn key should work properly after pressing Caps Lock
- If still experiencing issues, restart Karabiner Elements or reload the configuration

### fn Key Not Working When Caps Lock is Active
- **Fixed in latest version**: All fn key mappings now include `caps_lock` as an optional modifier
- This resolves the issue where fn key combinations don't work when Caps Lock is enabled
- The fix addresses Karabiner Elements 15.1.0+ breaking changes related to Caps Lock accidental keystroke prevention
- **What was fixed**: All 72 fn key mappings + Control+arrow combinations + toggle controls now work with Caps Lock active
- **Complete coverage**: Regular fn mappings, terminal fn mappings, arrow keys, and system toggle controls
- **Root cause**: When Caps Lock is active, it becomes part of the modifier state and mappings must explicitly include `caps_lock` as optional
- **Testing**: All functionality tested with both Caps Lock ON and OFF states

### Terminal Shortcuts Not Working
- Verify Terminal.app and Warp bundle identifiers are correct
- Check if you're using a different terminal app (add its bundle identifier to the config)



### Finding App Bundle Identifiers
```bash
# For running apps
osascript -e 'id of app "AppName"'

# For installed apps
mdls -name kMDItemCFBundleIdentifier -r /Applications/AppName.app
```

## Customization

### Adding More Applications
To add terminal behavior to other apps, edit the `bundle_identifiers` array:
```json
"bundle_identifiers": [
  "com.apple.Terminal",
  "dev.warp.Warp-Stable",
  "com.googlecode.iterm2",
  "your.terminal.app.bundle.id"
]
```

### Adding More Shortcuts
Add new manipulators to the appropriate rule section in `karabiner.json`.

### Modifying Toggle Keys
Change the toggle combinations in the "System toggle controls" section.

## Technical Details

- **Configuration Format**: Karabiner Elements JSON
- **Rule Priority**: Higher rules override lower ones
- **Variables**: Uses `windows_mapping_enabled` to control activation
- **Coverage**: Complete keyboard mapping - 26 letters + 10 numbers + 12 symbols = 48 keys
- **Shift Support**: All 48 base mappings × 2 (with/without shift) = 96+ combinations
- **Context Awareness**: Smart terminal vs regular app detection
- **Compatibility**: Tested on macOS with built-in MacBook keyboards

## Project Structure

```
ke-custom/
├── karabiner.json              # Main Karabiner Elements configuration
├── README.md                   # This file
├── CLAUDE.md                   # AI assistant guidance
├── btt/
│   └── btt-preset.bttpreset    # BetterTouchTool configuration
├── docs/
│   ├── karabiner-technical-learnings.md  # Technical insights and best practices
│   └── current-issues.md       # Known issues tracker
└── scripts/
    ├── deploy.sh               # Backup and deploy Karabiner config
    ├── revert.sh               # Restore previous Karabiner config
    ├── btt-export.sh           # Export BTT config to repo
    ├── btt-import.sh           # Import BTT config (adds to existing)
    └── btt-clean-import.sh     # DELETE all BTT config and import fresh
```

## Contributing

Feel free to submit issues or pull requests for:
- Additional shortcuts
- App-specific configurations  
- Bug fixes
- Documentation improvements
- Development process enhancements

## License

This configuration is provided as-is for personal use. Modify as needed for your workflow.

---

**🎉 Happy typing with your complete Windows muscle memory on Mac!** 

*Now featuring 100% keyboard coverage - every single key works exactly as you'd expect from Windows!* 