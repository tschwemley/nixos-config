{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # hints electron apps to use wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
