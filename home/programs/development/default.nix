{ pkgs, ... }:
{
  imports = [ ];
  home.packages = with pkgs; [
    insomnia
  ];
}
