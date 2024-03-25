{config, ...}: let
  ip = "127.0.0.1";
  port = toString config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations = {
        "/" = {
          proxyPass = "http://${ip}:${port}";
          proxyWebsockets = true;
          extraConfig = ''
            auth_request /auth;

            # include ${config.sops.templates.nginx_allow_secure.path};
          '';
        };

        "/auth" = {
          proxyPass = "http://127.0.0.1:4180/oauth/start?rd=https%3A%2F%2Fmonitor.schwem.io&allowed_groups=role:admin";
        };
      };
    };
  };
}
