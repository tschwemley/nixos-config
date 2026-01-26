{ pkgs, ... }:
{
  # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries
  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = 1; # enables automatic scaling (based on monitor pixel density)
    #     # QT_QPA_PLATFORM = "wayland;xcb"; # 'xcb' for X11; 'wayland;xcb' to fallback if wayland not available
    #     QT_QPA_PLATFORM = "wayland";
    #
    #     # NOTE: Due to Incorrect sizing and bad text rendering w/ WebEngine using fractional scaling on
    #     #       Wayland Qt WebEngine bug some apps may display jagged fonts. Uncomment for workaround:
    #     #
    #     # QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    #   };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  # TODO: move out into it's own file?
  home.packages = with pkgs; [
    krusader

    kdePackages.ark
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kio-extras
    kdePackages.kio-extras-kf5
    kdePackages.kio-fuse
    kdePackages.qtimageformats
    kdePackages.qtsvg
    qdirstat
  ];
}
