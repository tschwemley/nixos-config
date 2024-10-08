{
  services.nginx.virtualHosts = {
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
}
