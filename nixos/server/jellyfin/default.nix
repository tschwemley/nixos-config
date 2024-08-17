{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    jellyseerr.enable = true;
  };
}
