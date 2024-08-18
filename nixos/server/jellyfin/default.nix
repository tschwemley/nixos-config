{pkgs, ...}: {
  imports = [./virtualhost.nix];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    jellyseerr.enable = true;
  };
}
