{
  pkgs,
  nixosConfig,
  ...
}:
{
  # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries
  home = {
    packages =
      with pkgs;
      [
        # adwaita-qt
        adwaita-qt6
      ]
      ++ (if nixosConfig.programs.hyprland.enable then [ hyprland-qtutils ] else [ ]);

    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = 1; # enables automatic scaling (based on monitor pixel density)
      # QT_QPA_PLATFORM = "wayland;xcb"; # 'xcb' for X11; 'wayland;xcb' to fallback if wayland not available
      QT_QPA_PLATFORM = "wayland";

      # NOTE: Due to Incorrect sizing and bad text rendering w/ WebEngine using fractional scaling on
      #       Wayland Qt WebEngine bug some apps may display jagged fonts. Uncomment for workaround:
      #
      # QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    };
  };

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style.name = "gtk2";
  };
}
