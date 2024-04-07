{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    upower
    vaapiVdpau
  ];
}
