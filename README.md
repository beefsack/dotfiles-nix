# dotfiles-nix

My NixOS configuration, including home-manager, for multiple hosts.

## Features

- Flake-based
- Secure Boot via [lanzaboote](https://github.com/nix-community/lanzaboote)
- [COSMIC](https://github.com/pop-os/cosmic-epoch) desktop

## Usage

Apply config:

```sh
sudo nixos-rebuild boot --flake .
```

- Use `switch` instead of `boot` for smaller changes that don't need a reboot.
- Add `-j1` if the build hits resource exhaustion.

Update inputs:

```sh
nix flake update
```

Collect garbage regularly:

```sh
nix-collect-garbage -d && sudo nix-collect-garbage -d
```

## Maintenance principles

- Prefer NixOS/home-manager options over raw packages wherever possible.
- Only add external flakes when there is no alternative.
- Project-specific dependencies belong in a per-project devenv config, not here.
- Prefer home-manager over system-level config unless a package must be root for system maintenance.
- Prefer home-manager configuration modules over raw config files.
