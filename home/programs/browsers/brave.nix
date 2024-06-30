{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    # TODO: I don't think these are necessary here but double check
    # upower
    # vaapiVdpau
  ];
}
