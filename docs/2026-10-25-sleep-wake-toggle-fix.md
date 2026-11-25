# 2026-10-25: Mapping turned off after every sleep/wake (Karabiner 16)

Read this before touching the `windows_mapping_disabled` variable, the
"System toggle controls" rule, or the conditions on the other rules.

## Symptom

- Mapping used to be "always on". Anshul never thought about the toggle.
- After upgrading to Karabiner-Elements 16.3.0 (installed 2026-10-24 11:04,
  per `/var/log/karabiner/core_service.log`), every lid-close/sleep came back
  with the mapping OFF. He had to press `fn+ctrl+opt+cmd+E` each time.
- Nothing in Karabiner's Settings UI controls this. The on/off switch lives in
  this repo's config, not in Karabiner.

## How the config worked before this fix

```
88 manipulators  ──gated on──►  variable_if  windows_mapping_enabled == 1
fn+ctrl+opt+cmd+E  → set_variable windows_mapping_enabled = 1
fn+ctrl+opt+cmd+D  → set_variable windows_mapping_enabled = 0
profile.variables = {"windows_mapping_enabled": 1}   ← NOT a Karabiner feature
```

- Karabiner variables default to 0 when unset. So with this gate, the mapping
  is OFF until something sets the variable to 1.
- The profile-level `"variables"` key was added in July 2025 (first seen in
  `~/.config/karabiner/automatic_backups/karabiner_20250703.json`) with the
  intent of seeding the variable to 1 on load. It is not part of the
  karabiner.json schema (profile keys are `name`, `selected`,
  `simple_modifications`, `fn_function_keys`, `complex_modifications`,
  `virtual_hid_keyboard`, `devices`, `parameters`). Karabiner ignored it.
- So the only thing that ever set the variable to 1 was pressing the E hotkey.

## Why it used to work anyway

- Karabiner 15.x kept `karabiner_grabber` (later Karabiner-Core-Service)
  running across sleep. On wake it only re-grabbed the devices. Variables lived
  in that process's memory, so one press of E months ago stayed in effect
  through every sleep since.
- Evidence: `/var/log/karabiner/grabber.log` (Nov 2025, v15) shows on wake
  only `system_will_power_on` → `hid queue value monitor is started (grabbed)`.
  No config reload, no grabber restart.

## What changed in Karabiner 16

- 16.2.0 release note: "Fixed an issue where modifications could stop working
  for several seconds after waking from sleep on macOS."
- The implementation tears down and rebuilds the device grabber on every wake.
  In `/var/log/karabiner/core_service.log` (v16.3.0) every wake now logs:

  ```
  system_will_power_on
  system_has_powered_on
  device_grabber is started.
  Load /Users/anshul/.config/karabiner/karabiner.json...
  core_configuration is updated.
  ```

- A fresh grabber means a fresh manipulator environment: all user variables
  are back to 0. `windows_mapping_enabled == 1` is false, mapping is OFF.
- The config file had not changed since July 2025 (verified across every
  `automatic_backups/karabiner_*.json`). Only Karabiner changed.

## Fix

Invert the gate so the default (unset = 0) state means ON.

| Before | After |
|---|---|
| `variable_if windows_mapping_enabled == 1` | `variable_unless windows_mapping_disabled == 1` |
| E hotkey: `windows_mapping_enabled = 1` | E hotkey: `windows_mapping_disabled = 0` |
| D hotkey: `windows_mapping_enabled = 0` | D hotkey: `windows_mapping_disabled = 1` |
| `profile.variables` key present (no-op) | removed |

- 90 edits total: 88 conditions + 2 set_variable actions.
- Behavior now: mapping is ON after any wake, restart, config reload or
  profile switch. D turns it off until the next wake. E turns it back on.
- This does not depend on Karabiner version behavior, so it also keeps working
  if a future version stops (or starts) resetting variables on wake.

## Alternatives considered and rejected

- `karabiner_cli --set-variables '{"windows_mapping_enabled":1}'` from a
  sleep/wake watcher (sleepwatcher, launchd, Hammerspoon). Works, but adds a
  moving part that can race the grabber restart and needs its own install
  step on every machine. Inverting the gate needs nothing.
- Removing the toggle entirely. Anshul still wants the D/E hotkeys.

## How to verify

1. `fn+Tab` should produce `ctrl+Tab` without pressing E first.
2. Close the lid, wait a minute, reopen. `fn+Tab` still works.
3. `fn+ctrl+opt+cmd+D` shows "Windows Mapping: DISABLED" and `fn+Tab` stops
   working. Sleep/wake or `fn+ctrl+opt+cmd+E` brings it back.
4. Karabiner-EventViewer → Variables tab shows `windows_mapping_disabled`
   only after D or E has been pressed; absent means ON.

## Revert

Live config backup from before this change:
`~/.config/karabiner/karabiner.json.backup.2026-10-25_10-05-02-pre-invert`
(or `git checkout` the previous commit of `karabiner.json` and run
`./scripts/deploy.sh`).

## Sources

- Release notes: https://karabiner-elements.pqrs.org/docs/releasenotes/
- karabiner.json schema: https://karabiner-elements.pqrs.org/docs/json/root-data-structure/
- Live logs on this machine: `/var/log/karabiner/core_service.log`,
  `/var/log/karabiner/grabber.log`, `~/.local/share/karabiner/log/`
