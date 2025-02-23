{
  config,
  pkgs,
  ...
}: {
  imports = [./mimeapps.nix];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    # portal = {
    # enable = true;
    # extraPortals = [pkgs.xdg-desktop-portal-gtk];
    #   config = {
    #     common.default = ["gtk"];
    #     hyprland.default = ["gtk" "hyprland"];
    #   };
    # };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };

  home.packages = [
    # used by `gio open` and xdp-gtk
    # (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
    #   foot "$@"
    # '')
    pkgs.xdg-utils
  ];
}
