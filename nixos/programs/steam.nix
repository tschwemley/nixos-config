# TODO: this should be renamed as a game module instead of steam
{pkgs, ...}: {
  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  #   args = [
  #     "--rt"
  #     "--expose-wayland"
  #   ];
  # };

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    #
    # extraCompatPackages = [
    #   pkgs.proton-ge-bin
    # ];

    # gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sidequest
  ];
}
