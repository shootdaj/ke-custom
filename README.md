# Windows-to-Mac Keyboard Mapping for Karabiner Elements

Transform your MacBook keyboard to behave like a Windows keyboard, making it easier to use your Windows muscle memory on Mac.

## Overview

This Karabiner Elements configuration remaps your MacBook's modifier keys to mimic Windows keyboard behavior:

- **`fn` key** → Acts as **Windows Ctrl** (Mac Command) for most shortcuts
- **`Cmd` key** → Acts as **Windows Alt** (Mac Option) 
- **`Option` keys** → Act as **Windows Meta/Super** (Mac Command) for window management
- **`Control` key** → Acts as **Windows Fn** for navigation (word skipping, etc.)

## Key Features

### ✅ Core Productivity Shortcuts
All Windows shortcuts work with the `fn` key:
- `fn + C/V/X` → Copy/Paste/Cut
- `fn + Z/Y` → Undo/Redo  
- `fn + A` → Select All
- `fn + S` → Save
- `fn + N/O` → New/Open
- `fn + F` → Find
- `fn + W/T` → Close/New Tab
- `fn + Shift + T` → Reopen Tab

### ✅ Developer Navigation (Perfect for VSCode/Cursor)
- `Control + Left/Right Arrow` → Word skipping
- `Control + Shift + Left/Right Arrow` → Word selection
- `Control + Up/Down Arrow` → Document start/end
- `fn + Control + Left/Right Arrow` → Line start/end
- All navigation shortcuts support `Shift` for text selection

### ✅ Tab Management
- `fn + Tab` → Switch tabs forward (like Windows `Ctrl + Tab`)
- `fn + Shift + Tab` → Switch tabs backward

### ✅ Terminal Support
Special behavior in Terminal.app and Warp:
- `fn + C` → `Control + C` (kill process)
- `fn + D` → `Control + D` (EOF)
- `fn + Z` → `Control + Z` (suspend)  
- `fn + L` → `Control + L` (clear screen)

### ✅ Function Keys Preserved
- `fn + F1-F12` → Keep native Mac behavior (brightness, volume, etc.)

### ✅ Window Management Ready
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

## Usage

### Toggle On/Off
- **Enable**: `fn + Control + Option + Command + E`
- **Disable**: `fn + Control + Option + Command + D`

You'll see a notification when toggling the mapping on/off.

### BetterTouchTool Integration
Since Option keys now act as Command keys, update your BetterTouchTool shortcuts:
- Change window snapping shortcuts from `Option + Arrow` to `Command + Arrow`
- Or disable BetterTouchTool's window snapping and use a dedicated window manager

## Common Shortcuts Reference

### Productivity
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + C` | `fn + C` | Copy |
| `Ctrl + V` | `fn + V` | Paste |
| `Ctrl + Z` | `fn + Z` | Undo |
| `Ctrl + A` | `fn + A` | Select All |
| `Ctrl + S` | `fn + S` | Save |
| `Ctrl + F` | `fn + F` | Find |

### Navigation (Great for Coding)
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + Left` | `Control + Left` | Word skip left |
| `Ctrl + Right` | `Control + Right` | Word skip right |
| `Ctrl + Home` | `Control + Up` | Document start |
| `Ctrl + End` | `Control + Down` | Document end |
| `Home` | `fn + Control + Left` | Line start |
| `End` | `fn + Control + Right` | Line end |

### Browser/App Navigation
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + Tab` | `fn + Tab` | Next tab |
| `Ctrl + Shift + Tab` | `fn + Shift + Tab` | Previous tab |
| `Ctrl + W` | `fn + W` | Close tab |
| `Ctrl + T` | `fn + T` | New tab |
| `Ctrl + Shift + T` | `fn + Shift + T` | Reopen tab |

### Terminal
| Windows Shortcut | Mac Keys (with mapping) | Result |
|------------------|-------------------------|---------|
| `Ctrl + C` | `fn + C` | Kill process |
| `Ctrl + D` | `fn + D` | EOF |
| `Ctrl + Z` | `fn + Z` | Suspend |
| `Ctrl + L` | `fn + L` | Clear screen |

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
│   └── add-chat-log.sh        # Script to create new chat log entries
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

**Happy typing with your Windows muscle memory on Mac! 🎉** 