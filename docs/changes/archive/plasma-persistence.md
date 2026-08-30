# Plasma Persistence

## Goal

Persist per-screen virtual desktops and the configured panel pager behavior.

## Scope

- Enable KWin per-output virtual desktops.
- Preserve the pager desktop-number label and enable window-outline icons and current-screen filtering.
- Do not add a panel replication mechanism for hot-plugged displays.

## Acceptance

- Plasma Manager evaluation accepts the KWin and pager configuration.
- Per-output desktops and the requested pager settings are declaratively written.
- The panel configuration remains monitor-count independent without a brittle runtime workaround.

## Decision

Plasma Manager's `screen = "all"` expands only the displays present when its startup script runs and does not handle display hotplugging. It is not used.

## Verification

- `nix flake show --no-update-lock-file` passed for all four hosts.
- Targeted `nix eval --json` assertions passed for generated KWin, pager, and panel output on `beefsack-den`, `beefsack-house`, `beefsack-laptop`, and `beefsack-usb`.
- `git diff --check` passed.

## Outcome

The generated KWin configuration sets `Windows/PerOutputVirtualDesktops=true`. The pager retains its desktop-number label and generates window outlines, application icons, and current-screen filtering.
