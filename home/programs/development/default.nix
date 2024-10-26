{ pkgs, ... }:
{
  imports = [ ];
  home.packages = with pkgs; [
    inotify-tools
    insomnia
  ];
}
