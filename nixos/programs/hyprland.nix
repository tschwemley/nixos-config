{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };
}
