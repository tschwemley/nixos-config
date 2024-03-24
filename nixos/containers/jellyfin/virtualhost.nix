{config, ...}: {
  services.nginx.virtualHosts."jellyfin.schwem.io" = {
    locations."/" = {
      proxyPass = "http://10.10.3.2:8096";
      extraConfig = ''
        include ${config.sops.templates.nginx_allow_secure.path};
      '';
    };
  };
}
