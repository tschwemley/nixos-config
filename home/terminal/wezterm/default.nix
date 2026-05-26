{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile = {
    "wezterm/fonts.lua".source = ./config/fonts.lua;
    "wezterm/keys".source = ./config/keys;
    "wezterm/wezterm.lua".source = ./config/wezterm.lua;

    # "wezterm/keys.lua".source = ./config/keys.lua;
    # "wezterm/ssh_domains.lua".source = ./config/ssh_domains.lua;
  };
}
