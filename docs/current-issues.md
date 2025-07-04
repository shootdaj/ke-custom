# Current Issues

## Issue #1: Cmd + Tab not working with BTT configuration page
**Status:** Open  
**Description:** The `cmd + tab` application switcher doesn't work while the BetterTouchTool (BTT) configuration page is open.  
**Impact:** Users cannot switch between applications when BTT config is active.  
**Investigation needed:** Determine if this is a BTT-specific issue or related to our Karabiner configuration.

## Issue #2: Fn + Return and Right Option + Return mapping
**Status:** Open  
**Description:** 
- `fn + return` should function like `ctrl + return` on Windows
- `right option + return` should also function like `ctrl + return` on Windows
- `right option` should always act like the `ctrl` modifier on Windows (not just with return)

**Impact:** Missing Windows-style behavior for these key combinations.  
**Investigation needed:** 
- Determine what `ctrl + return` does on Windows (likely new line in forms, submit in dialogs)
- Check if `right option` is currently mapped to any modifier
- Implement proper Windows-style modifier behavior for right option (should act as Ctrl for all combinations, not just return)

## Issue #3: Fn + Tab opens Quick Open instead of Recent Files in Cursor
**Status:** Open  
**Description:** 
- `fn + tab` currently opens the Quick Open dialog in Cursor (Cmd+P)
- The intended behavior was to open the Recent Files picker (Cmd+E)
- This is a workaround because we couldn't get the Recent Files picker to work properly

**Impact:** Users get Quick Open instead of Recent Files when using fn+Tab in Cursor.  
**Workaround:** Use `fn + e` to open Recent Files picker in Cursor.
**Investigation needed:** 
- Determine why Cmd+E (Recent Files) doesn't work reliably in Cursor
- Check if there are alternative shortcuts for Recent Files in Cursor
- Consider if this limitation should be documented in the README

---

*Last updated: 2025-07-04* 