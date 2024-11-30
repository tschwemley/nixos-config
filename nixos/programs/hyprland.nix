{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  # hints electron apps to use wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
