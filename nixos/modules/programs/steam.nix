{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gamescope
  ];
  programs.steam = {
    enable = true;
    # TODO: remove or enable based on if I use this
    #remotePlay.openFirewall = true;
  };
}
