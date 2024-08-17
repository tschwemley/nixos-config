{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

  services.jellyfin = {
    enable = true;
    jellyseer.enable = true;
    openFirewall = true;
  };
}
