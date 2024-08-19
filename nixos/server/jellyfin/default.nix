{pkgs, ...}: {
  imports = [./virtualhost.nix];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

  # open port for jellyseerr since openFirewall doesn't include it
  networking.firewall.allowedTCPPorts = [5055];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    jellyseerr.enable = true;
  };
}
