{config, ...}: {
  imports = [./virtualhost.nix];

  # sops.secrets.db_password = {
  #   sopsFile = ./secrets.yaml;
  #   mode = "0444";
  # };

  containers.jellyfin = {
    autoStart = true;

    # bindMounts."/run/secrets/db_password" = {
    #   hostPath = config.sops.secrets.db_password.path;
    # };

    # network
    privateNetwork = true;
    hostAddress = "10.10.3.1";
    localAddress = "10.10.3.2";
    hostAddress6 = "fc00::31";
    localAddress6 = "fc00::32";

    config = {
      lib,
      pkgs,
      ...
    }: {
      imports = [../.];

      environment.systemPackages = with pkgs; [
        jellyfin
        jellyfin-ffmpeg
        jellyfin-web
      ];

      services.jellyfin = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
