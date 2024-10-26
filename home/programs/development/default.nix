{ pkgs, ... }:
{
  imports = [ ];
  home.packages = with pkgs; [
    fswatch
  ];
}
