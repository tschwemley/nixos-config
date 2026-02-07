{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
    # legcord
  ];
}
