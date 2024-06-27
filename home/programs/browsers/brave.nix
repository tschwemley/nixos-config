{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    # TODO: I don't think these are necessary here but double check
    # upower
    # vaapiVdpau
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
  };
}
