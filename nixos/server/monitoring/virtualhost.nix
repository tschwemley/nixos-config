{config, ...}: let
  ip = "127.0.0.1";
  port = toString config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        # proxyPass = "http://${ip}:${port}";
        proxyPass = "https://auth.schwem.io/oauth/start?rd=http://${ip}:${port}&allowed_groups=role:admin";
        proxyWebsockets = true;
        extraConfig = ''
          include ${config.sops.templates.nginx_allow_secure.path};
          #   auth_request /sign-in;
          #   error_page 401 =403 /sign-in;
          #
        '';
      };
    };
  };
}
