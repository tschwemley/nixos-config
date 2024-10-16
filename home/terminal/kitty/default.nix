{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklig";
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
      enabled_layouts = "tall:bias=65,fat:bias=67,grid,stack";
      listen_on = "unix:@kitty";
    };
    shellIntegration.enableFishIntegration = false;
    themeFile = "gruvbox-dark";
  };
}
