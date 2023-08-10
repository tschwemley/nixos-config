{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [zk];
  xdg.configFile."zk/config.toml".source = ./config.toml;
}
