{pkgs, ...}: {
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

    nginx.virtualHosts = {
      "jellyfin.schwem.io" = {
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:8096";
            extraConfig = ''
              proxy_buffering off;
            '';
            # proxyWebsockets = true;
          };
          "/socket" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true;
            # extraConfig = ''
            #   proxy_set_header X-Forwarded-Protocol $scheme;
            # '';
          };
        };
      };
      "jellyseerr.schwem.io" = {
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:5055";
          };
        };
      };
    };
  };

  users.users.jellyfin.extraGroups = ["users"];
}
