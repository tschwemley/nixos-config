{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./mimeapps.nix ];

  xdg = {
    enable = true;

    # autostart = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    portal = {
      enable = true;

      config = {
        common = {
          default = [
            "gtk"
            "gnome"
          ];
        };
        niri = {
          default = [
            "gnome"
            "gtk"
          ];

          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.portal.ScreenCast" = "gnome";
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      xdgOpenUsePortal = true;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };

  home.packages = [
    pkgs.xdg-utils
  ];
}
