# Windows-to-Mac Keyboard Mapping for Karabiner Elements

Transform your MacBook keyboard to behave like a Windows keyboard, making it easier to use your Windows muscle memory on Mac.

## Overview

This Karabiner Elements configuration remaps your MacBook's modifier keys to mimic Windows keyboard behavior:

- **`fn` key** → Acts as **Windows Ctrl** (Mac Command) for ALL shortcuts
- **`Cmd` key** → Acts as **Windows Alt** (Mac Option) 
- **`Option` keys** → Act as **Windows Meta/Super** (Mac Command) for window management
- **`Control` key** → Acts as **Windows Fn** for navigation (word skipping, etc.)

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

### ✅ **Developer Navigation (Perfect for VSCode/Cursor)**
- `Control + Left/Right Arrow` → Word skipping
- `Control + Shift + Left/Right Arrow` → Word selection
- `Control + Up/Down Arrow` → Document start/end
- `fn + Control + Left/Right Arrow` → Line start/end
- All navigation shortcuts support `Shift` for text selection

### ✅ **Tab Management**
- `fn + Tab` → Switch tabs forward (like Windows `Ctrl + Tab`)
- `fn + Shift + Tab` → Switch tabs backward

### ✅ **Shift Variant Support**
Every mapping automatically supports shift combinations:
- `fn + Shift + T` → `Command + Shift + T` (reopen closed tab)
- `fn + Shift + Z` → `Command + Shift + Z` (redo)
- `fn + Shift + [number]` → `Command + Shift + [number]`
- And hundreds more combinations

### ✅ **Function Keys Preserved**
- `fn + F1-F12` → Keep native Mac behavior (brightness, volume, etc.)

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

### For Contributors
If you plan to contribute to this project, set up the git hooks for proper development workflow:

```bash
# Install git hooks that encourage documentation
./scripts/setup-git-hooks.sh
```

This installs a pre-commit hook that:
- **Checks for chat history** when committing code changes
- **Prompts for confirmation** if no development session is documented  
- **Verifies README updates** when `karabiner.json` is modified
- **Provides helpful workflow reminders** for proper documentation

## Usage

### Toggle On/Off
- **Enable**: `fn + Control + Option + Command + E`
- **Disable**: `fn + Control + Option + Command + D`

You'll see a notification when toggling the mapping on/off.

### BetterTouchTool Integration
Since Option keys now act as Command keys, update your BetterTouchTool shortcuts:
- Change window snapping shortcuts from `Option + Arrow` to `Command + Arrow`
- Or disable BetterTouchTool's window snapping and use a dedicated window manager

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
| `Ctrl + Tab` | `fn + Tab` | Next tab |
| `Ctrl + Shift + Tab` | `fn + Shift + Tab` | Previous tab |
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
| `Ctrl + Left` | `Control + Left` | Word skip left |
| `Ctrl + Right` | `Control + Right` | Word skip right |
| `Ctrl + Home` | `Control + Up` | Document start |
| `Ctrl + End` | `Control + Down` | Document end |
| `Home` | `fn + Control + Left` | Line start |
| `End` | `fn + Control + Right` | Line end |
| `Ctrl + Shift + Left` | `Control + Shift + Left` | Select word left |
| `Ctrl + Shift + Right` | `Control + Shift + Right` | Select word right |

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
├── README.md                   # This file - installation and usage guide
├── docs/                       # Documentation and development logs
│   ├── karabiner-elements-plan.md  # Detailed development plan and specifications
│   └── chats/                  # AI conversation logs from development sessions
│       ├── README.md           # Chat logging system documentation
│       └── *.md                # Individual conversation exports
├── scripts/                    # Helper scripts
│   ├── add-chat-log.sh        # Script to create new chat log entries
│   └── setup-git-hooks.sh     # Script to install git hooks for contributors
└── .gitignore                 # Git ignore rules
```

## Documentation

The [`docs/`](./docs/) folder contains comprehensive documentation for this project:

### Development Plan
- [`docs/karabiner-elements-plan.md`](./docs/karabiner-elements-plan.md) - Detailed technical specifications, development roadmap, and design decisions

### Development Logs  
- [`docs/chats/`](./docs/chats/) - AI-assisted development session logs that provide:
  - **Context** for design decisions and implementation choices
  - **Troubleshooting history** for common issues
  - **Evolution** of the configuration over time
  - **Reference** for future enhancements

#### Adding New Chat Logs
To add a new development chat log:

1. **Export from Cursor**: 
   - Click the menu (⋮) in the chat panel → "Export Chat" 
   - Save the `.md` file to `docs/chats/exported/`

2. **Run the script**: 
   ```bash
   ./scripts/add-chat-log.sh
   ```
   The script automatically finds and processes the latest exported file

3. **Automatic organization**: 
   - Creates timestamped file: `docs/chats/YYYY-MM-DD_HH-MM-SS.md`
   - Removes the original export file
   - Ready for git commit

See [`docs/chats/README.md`](./docs/chats/README.md) for detailed workflow and best practices.

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