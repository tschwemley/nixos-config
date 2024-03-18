{config, ...}: let
  ip = "10.10.69.2";
  port = "9999";
in {
  services.nginx.virtualHosts."stash.schwem.io" = {
    locations = {
      "/" = {
        proxyPass = "http://${ip}:${port}";
        extraConfig = ''
          include ${config.sops.templates.nginx_allow_secure.path};
        '';
      };
    };
  };
}
