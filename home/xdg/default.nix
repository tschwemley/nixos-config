{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./mimeapps.nix ];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

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
