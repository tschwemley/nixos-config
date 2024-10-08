{config, ...}: let
  ip = "${config.networking.hostName}.wyvern-map.ts.net";
  port = "26080";
in {
  services.nginx = {
    virtualHosts."db.schwem.io" = {
      locations."/" = {
        proxyPass = "https://${ip}:${port}";
        # extraConfig = ''
        #   include ${config.sops.templates.nginx_allow_secure.path};
        # '';
      };
    };
  };
}
