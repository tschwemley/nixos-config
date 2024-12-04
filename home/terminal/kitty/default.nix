{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklug Nerd Font Mono";
      size = 18;
    };
    keybindings = {
      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+alt+l" = "next_layout";
      "ctrl+shift+," = "toggle_layout stack";

      "ctrl+h" = "kitten pass_keys.py left ctrl+h";
      "ctrl+j" = "kitten pass_keys.py bottom ctrl+j";
      "ctrl+k" = "kitten pass_keys.py top ctrl+k";
      "ctrl+l" = "kitten pass_keys.py right ctrl+l";
    };
    settings = {
      allow_remote_control = "yes";
      enable_audio_bell = false;
      enabled_layouts = "fat:bias=75,tall:bias=67,grid,stack";
      listen_on = "unix:@kitty";
    };
    shellIntegration.enableFishIntegration = false;
    themeFile = "gruvbox-dark";

    extraConfig = ''
      # Nerd Fonts v3.2.0 -- NOTE: including these allows them to scale when using a mono or patched font
      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono
    '';
  };
}
