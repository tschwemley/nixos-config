# TODO: this should be renamed as a game module instead of steam
{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    # NOTE: for VR
    android-tools
    sidequest

    lutris
  ];
}
