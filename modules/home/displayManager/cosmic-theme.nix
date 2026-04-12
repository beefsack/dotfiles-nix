{ mkRON }: {
  mode = "dark";
  dark = {
    accent = mkRON "optional" { red = 0.741; green = 0.576; blue = 0.976; };
    active_hint = 3;
    bg_color = mkRON "optional" { red = 0.157; green = 0.165; blue = 0.212; alpha = 1.0; };
    corner_radii = {
      radius_0  = mkRON "tuple" [ 0.0   0.0   0.0   0.0   ];
      radius_xs = mkRON "tuple" [ 4.0   4.0   4.0   4.0   ];
      radius_s  = mkRON "tuple" [ 8.0   8.0   8.0   8.0   ];
      radius_m  = mkRON "tuple" [ 16.0  16.0  16.0  16.0  ];
      radius_l  = mkRON "tuple" [ 32.0  32.0  32.0  32.0  ];
      radius_xl = mkRON "tuple" [ 160.0 160.0 160.0 160.0 ];
    };
    gaps = mkRON "tuple" [ 0 8 ];
    is_frosted = false;
    neutral_tint = mkRON "optional" { red = 0.467; green = 0.467; blue = 0.467; };
    text_tint = mkRON "optional" { red = 0.908; green = 0.908; blue = 0.908; };
    palette = mkRON "enum" {
      variant = "Dark";
      value = [{
        name = "cosmic-dark";
        blue         = { red = 0.580; green = 0.922; blue = 0.922; alpha = 1.0; };
        red          = { red = 1.0;   green = 0.710; blue = 0.710; alpha = 1.0; };
        green        = { red = 0.675; green = 0.969; blue = 0.824; alpha = 1.0; };
        yellow       = { red = 1.0;   green = 0.945; blue = 0.620; alpha = 1.0; };
        gray_1       = { red = 0.106; green = 0.106; blue = 0.106; alpha = 1.0; };
        gray_2       = { red = 0.149; green = 0.149; blue = 0.149; alpha = 1.0; };
        gray_3       = { red = 0.188; green = 0.188; blue = 0.188; alpha = 1.0; };
        neutral_0    = { red = 0.0;   green = 0.0;   blue = 0.0;   alpha = 1.0; };
        neutral_1    = { red = 0.106; green = 0.106; blue = 0.106; alpha = 1.0; };
        neutral_2    = { red = 0.188; green = 0.188; blue = 0.188; alpha = 1.0; };
        neutral_3    = { red = 0.278; green = 0.278; blue = 0.278; alpha = 1.0; };
        neutral_4    = { red = 0.369; green = 0.369; blue = 0.369; alpha = 1.0; };
        neutral_5    = { red = 0.467; green = 0.467; blue = 0.467; alpha = 1.0; };
        neutral_6    = { red = 0.569; green = 0.569; blue = 0.569; alpha = 1.0; };
        neutral_7    = { red = 0.671; green = 0.671; blue = 0.671; alpha = 1.0; };
        neutral_8    = { red = 0.776; green = 0.776; blue = 0.776; alpha = 1.0; };
        neutral_9    = { red = 0.886; green = 0.886; blue = 0.886; alpha = 1.0; };
        neutral_10   = { red = 1.0;   green = 1.0;   blue = 1.0;   alpha = 1.0; };
        bright_green  = { red = 0.369; green = 0.859; blue = 0.549; alpha = 1.0; };
        bright_red    = { red = 1.0;   green = 0.627; blue = 0.565; alpha = 1.0; };
        bright_orange = { red = 1.0;   green = 0.639; blue = 0.490; alpha = 1.0; };
        ext_warm_grey = { red = 0.608; green = 0.557; blue = 0.541; alpha = 1.0; };
        ext_orange    = { red = 1.0;   green = 0.678; blue = 0.0;   alpha = 1.0; };
        ext_yellow    = { red = 0.996; green = 0.859; blue = 0.251; alpha = 1.0; };
        ext_blue      = { red = 0.282; green = 0.725; blue = 0.780; alpha = 1.0; };
        ext_purple    = { red = 0.812; green = 0.490; blue = 1.0;   alpha = 1.0; };
        ext_pink      = { red = 0.976; green = 0.227; blue = 0.514; alpha = 1.0; };
        ext_indigo    = { red = 0.243; green = 0.533; blue = 1.0;   alpha = 1.0; };
        accent_blue   = { red = 0.388; green = 0.816; blue = 0.875; alpha = 1.0; };
        accent_red    = { red = 0.992; green = 0.631; blue = 0.627; alpha = 1.0; };
        accent_green  = { red = 0.573; green = 0.812; blue = 0.612; alpha = 1.0; };
        accent_warm_grey = { red = 0.792; green = 0.729; blue = 0.706; alpha = 1.0; };
        accent_orange = { red = 1.0;   green = 0.678; blue = 0.0;   alpha = 1.0; };
        accent_yellow = { red = 0.969; green = 0.878; blue = 0.384; alpha = 1.0; };
        accent_purple = { red = 0.906; green = 0.612; blue = 0.996; alpha = 1.0; };
        accent_pink   = { red = 1.0;   green = 0.612; blue = 0.694; alpha = 1.0; };
        accent_indigo = { red = 0.631; green = 0.753; blue = 0.922; alpha = 1.0; };
      }];
    };
  };
}
