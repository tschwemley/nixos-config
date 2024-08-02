{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklig";
      size = 18;
    };
    keybindings = {
      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+alt+l" = "next_layout";
      "ctrl+shift+," = "toggle_layout stack";
    };
    settings = {
      allow_remote_control = "yes";
      enable_audio_bell = false;
      enabled_layouts = "tall:bias=65,fat:bias=67,grid,stack";
      listen_on = "unix:@kitty";
    };
    shellIntegration.enableFishIntegration = false;
    theme = "Gruvbox Dark";
  };
}
