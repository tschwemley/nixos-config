{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    nautilus
    xwayland-satellite
  ];
}
