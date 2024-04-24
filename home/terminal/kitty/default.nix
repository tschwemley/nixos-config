{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklig";
      size = 18;
    };
    keybindings = {
      "ctrl+h" = "kitten pass_keys.py bottom ctrl+h";
      "ctrl+l" = "kitten pass_keys.py left ctrl+l";
      "ctrl+k" = "kitten pass_keys.py top ctrl+k";
      "ctrl+j" = "kitten pass_keys.py right ctrl+j";
    };
    settings = {
      allow_remote_control = "yes";
      enable_audio_bell = false;
      listen_on = "unix:@kitty";
    };
    shellIntegration.enableFishIntegration = false;
    theme = "Gruvbox Dark";
  };
}
