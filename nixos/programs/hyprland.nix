{

  environment.variables = {
    NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
    WAYLAND_DISPLAY = "1";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = { };
}
