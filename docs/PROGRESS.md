# Progress

## 2026-10-25 Session

### Completed
- Fixed mapping turning OFF after every sleep/wake since the Karabiner 16.3.0 upgrade
  - Root cause: Karabiner 16.2+ restarts the device grabber on wake, wiping in-memory variables; the mapping was gated on `windows_mapping_enabled == 1`, which only the E hotkey ever set
  - Fix: inverted the gate to `variable_unless windows_mapping_disabled == 1` so unset = ON; E/D hotkeys now clear/set `windows_mapping_disabled`; dropped the bogus profile-level `variables` key
  - Full write-up: `docs/2026-10-25-sleep-wake-toggle-fix.md`
- Synced the live `~/.config/karabiner/karabiner.json` back into the repo (it also carries the `global` notification settings that were only live before)

### Current State
- Mapping is on by default and survives sleep/wake; D hotkey disables until next wake
- Deployed live on 2026-10-25 10:05, config reloaded with no errors

---

## 2026-01-28 Session

### Completed
- Deployed Karabiner config with forward delete mappings
- Updated BTT Warp shortcut to open new window instead of just launching app
  - Uses AppleScript: `do shell script "open -n -a Warp"`
- Created BTT backup workflow with video walkthrough
- Tested BTT clean import/export cycle

### Current State
- Karabiner deployed with Control+Backspace mappings
- BTT preset updated with Warp new window functionality
- All changes committed and pushed

---

## 2026-01-22 Session

### Completed
- Added forward delete mappings:
  - `Control + Backspace` → delete character forward
  - `Control + fn + Backspace` → delete word forward
- Simplified deployment workflow:
  - Replaced `deploy-test.sh`/`deploy-final.sh` with simple `deploy.sh` and `revert.sh`
  - Removed multi-profile system in favor of backup → deploy → test → keep/revert
- Major repo cleanup:
  - Removed `bak/` folder (old backups)
  - Removed `.cursorrules`/`.cursorignore` (replaced by CLAUDE.md)
  - Removed `docs/chats/` (15+ old AI chat logs)
  - Removed outdated docs (plan, version-history, tab-switching-progress)
  - Removed pre-commit git hook
- Added BetterTouchTool config sync:
  - Export BTT preset to `btt/btt-preset.bttpreset`
  - `btt-export.sh` - save BTT changes to repo
  - `btt-import.sh` - import on new machine (adds to existing)
  - `btt-clean-import.sh` - destructive fresh import
- Updated README and CLAUDE.md to reflect all changes

### Current State
- Repo is clean and simplified
- Both Karabiner and BTT configs are now version-controlled
- Simple scripts for deploying across machines

### Pending
- Test forward delete mappings (draft profile deployed)
- Known issues in `docs/current-issues.md` still open
