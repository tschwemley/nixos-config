{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklig";
      size = 18;
    };
    # keybindings = {
    #   "ctrl+alt+l" = "next_layout";
    #   "ctrl+shift+h" = "neighboring_window left";
    #   "ctrl+shift+l" = "neighboring_window right";
    #   "ctrl+shift+k" = "neighboring_window up";
    #   "ctrl+shift+j" = "neighboring_window down";
    # };
    settings = {
      allow_remote_control = "yes";
      enable_audio_bell = false;
      listen_on = "unix:@kitty";
    };
    shellIntegration.enableFishIntegration = false;
    theme = "Gruvbox Dark";
  };
}
