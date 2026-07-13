{ username, ... }: {
  imports = [
    ../programs/neovim
    # ../programs/yazi

    ../terminal/wezterm
  ];

  home = {
    inherit username;

    homeDirectory = "/Users/${username}";
    sessionVariables.TERM = "wezterm";
    stateVersion = "26.05";
  };
}
