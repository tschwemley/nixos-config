{
  config,
  pkgs,
  ...
}: {
  imports = [./mimeapps.nix];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    # TODO: reasses if this should be enabled or not (or is nixos portal fine)
    #
    # portal = {
    #   enable = true;
    #
    #   config = {
    #     common.default = ["gtk"];
    #     hyprland.default = ["gtk" "hyprland"];
    #   };
    #
    #   extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    #   xdgOpenUsePortal = true;
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
    # TODO: is necessary?
    #
    # used by `gio open` and xdp-gtk
    # (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
    #   foot "$@"
    # '')
    pkgs.xdg-utils
  ];
}
