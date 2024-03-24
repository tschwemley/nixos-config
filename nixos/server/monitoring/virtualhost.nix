{config, ...}: let
  ip = "127.0.0.1";
  port = toString config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${ip}:${port}";
        proxyWebsockets = true;
        extraConfig = ''
          auth_request /sign-in;
          error_page 401 =403 /sign-in;

          include ${config.sops.templates.nginx_allow_secure.path};
        '';
      };

      locations."/auth" = {
        proxyPass = "https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin";
        extraConfig = ''
          internal;
        '';
      };

      locations."/sign-in" = {
        proxyPass = "https://auth.schwem.io/oauth2/start?rd=https://monitor.schwem.io&allowed_groups=role:admin";
        extraConfig = ''
          internal;
        '';
      };
    };
  };
}
