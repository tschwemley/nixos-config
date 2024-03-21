{config, ...}: let
  ip = "10.10.80.2";
in {
  services.nginx.virtualHosts."arr.schwem.io" = {
    locations = {
      "/radarr " = {
        proxyPass = "http://${ip}:7878";
        proxyWebsockets = true;
        extraConfig = ''
          include ${config.sops.templates.nginx_allow_secure.path};
        '';
      };
    };
  };
}
