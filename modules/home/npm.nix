{ pkgs, lib, ... }:

let
  mkNpxBin =
    name: pkg:
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = [ pkgs.nodejs ];
      text = ''
        exec ${lib.getExe pkgs.nodejs} ${pkgs.nodejs}/lib/node_modules/npm/bin/npx-cli.js --yes ${pkg} "$@"
      '';
    };
in
{
  home.packages = [
    (mkNpxBin "claude" "@anthropic-ai/claude-code")
    (mkNpxBin "codex" "@openai/codex")
    (mkNpxBin "opencode" "opencode-ai@latest")
    (mkNpxBin "gemini" "@google/gemini-cli")
  ];
}
