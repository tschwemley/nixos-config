{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bitwarden-desktop
    rbw
  ];

  sops.secrets.rbw-config = {
    key = "";
    format = "json";
    path = "${config.home.homeDirectory}/.config/rbw/config.json";

    sopsFile = lib.secret "home" "rbw.json";
  };

  # xdg.configFile."rbw/config.json".source = config.sops.secrets.rbw-config.path;
}
