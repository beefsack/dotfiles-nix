# Plasma Auto Tiler Integration

## Goal

Integrate the verified `plasma-auto-tiler` GitHub flake into the current NixOS host and Home Manager user configuration.

## Scope

- Add the producer flake input with its `nixpkgs` following this flake's `nixpkgs`.
- Import and enable its NixOS module for `beefsack-laptop`.
- Import and enable its Home Manager module and tray for user `beefsack` using existing Plasma configuration conventions.
- Update only the new input's lock graph and evaluate the target without live mutation.

## Non-Goals

- Changes to the producer repository.
- Enabling the active-border effect, taking ownership of broader `kwinrc` settings, or configuring shortcuts.
- Rebuild, activation, KWin mutation, commit, or push.

## Acceptance

- The input is pinned to the verified GitHub producer and follows consumer `nixpkgs`.
- `beefsack-laptop` enables the NixOS module.
- The `beefsack` Home Manager configuration imports the module and enables its tray item.
- The lock diff only adds the producer node and its root reference.
- A no-sudo target configuration evaluation succeeds.

## Plan

1. Implement the bounded consumer integration and update the single input lock graph.
2. Independently inspect the diff and evaluation evidence.
3. Archive this record and stage accepted consumer files only.

## Outcome

- Added the producer flake input at revision `bc7b0fb811d3b8ffca98d2134532aab5a98f3b60` with its `nixpkgs` following the consumer input.
- Imported and enabled the NixOS module only for `beefsack-laptop`.
- Added the Home Manager module to shared modules and enabled its tray under the existing Plasma condition for `beefsack`.
- Added the producer's StatusNotifierItem identifier, `plasma-auto-tiler`, to the explicit Plasma tray list.
- The lock graph adds only the producer node and root input reference. Existing nodes are unchanged.

## Evidence

- `nix eval .#nixosConfigurations.beefsack-laptop.config.programs.plasma-auto-tiler.enable` returned `true`.
- `nix eval .#nixosConfigurations.beefsack-laptop.config.home-manager.users.beefsack.programs.plasma-auto-tiler.tray.enable` returned `true`.
- Evaluated `/etc/xdg/kwinrc` contains only the namespaced script enablement key and no active-border key.
- Evaluated tray autostart points to the immutable `/nix/store/.../bin/plasma-auto-tiler` path.
- `git diff --check` passed. Independent review found no findings.
