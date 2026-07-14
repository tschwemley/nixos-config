{ pkgs, username, ... }: {
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

    packages = with pkgs; [
      fontconfig
      search-nf

      gum # TODO: remove me after testing
    ];
  };

  fonts = {
    fontconfig = {
      enable = true;

      # defaultFonts = {
      #   emoji = [ "Twitter Color Emoji" ];
      #   monospace = [ "CaskaydiaCove Nerd Font" ];
      #   serif = [ "Inter" ];
      #   sansSerif = [ "Inter" ];
      # };

      # Hinting aligns glyphs to pixel boundaries to improve rendering sharpness at low resolution
      hinting = {
        enable = true;

        # slight (fuzzier but more grid align, retains shape) -> medium -> full (opposite slight)
        style = "full";
      };

      useEmbeddedBitmaps = true;
    };

    fontDir.enable = true;

    packages = with pkgs; [
      inter # used for reaper theme(s)
      nerd-fonts.caskaydia-cove
      twemoji-color-font
    ];
  };
}
