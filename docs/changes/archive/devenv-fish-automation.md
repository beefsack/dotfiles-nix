# Devenv Fish Automation

## Goal

Replace Fish direnv activation with devenv's supported Home Manager integration.

## Scope

- Enable Home Manager's devenv Fish integration.
- Remove the direnv integration, redundant package declaration, and direnv project file.
- Do not change the project devenv environment or unrelated shell behavior.

## Acceptance

- Fish gets the documented `devenv hook fish | source` integration through Home Manager.
- direnv no longer configures Fish or activates this project.
- devenv remains installed through its Home Manager module.
- Bash, Nushell, and Zsh retain their prior lack of devenv hooks.

## Approach

- Replace `programs.direnv` with Fish-only `programs.devenv` integration in the terminal module.
- Remove the standalone devenv package and `.envrc` because native devenv activation has no direnv dependency.

## Verification

- `nix flake show --no-update-lock-file` evaluated all four hosts.
- Each host's `config.system.build.toplevel.drvPath` evaluated without building.
- The effective `beefsack-den` Fish initialization contains `devenv hook fish | source` and no direnv hook; `programs.direnv.enable` is false.
- The effective Bash, Nushell, and Zsh initialization contains no devenv hook.
- `git diff --check` passed.

## Outcome

Home Manager's supported devenv module now installs devenv and initializes Fish with the native hook. Directory entry starts the allowed devenv project shell in a subshell. direnv and `.envrc` are no longer part of this activation path.
