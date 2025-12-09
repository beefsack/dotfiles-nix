{ ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "dockerfile"
      "dracula"
      "graphql"
      "less"
      "nix"
      "php"
      "ruby"
      "scss"
      "sql"
    ];
    userSettings = {
      buffer_font_family = "SauceCodePro Nerd Font";
      buffer_font_size = 16;
      buffer_font_weight = 500;
      "experimental.theme_overrides" = {
        "background.appearance" = "opaque";
      };
      languages = {
        Rust = {
          wrap_guides = [120];
        };
      };
      theme = {
        light = "One Light";
        dark = "Dracula";
        mode = "system";
      };
      ui_font_size = 16;
      vim_mode = true;
      wrap_guides = [80];
    };
  };
}
