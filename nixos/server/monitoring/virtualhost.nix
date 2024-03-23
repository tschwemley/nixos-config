{config, ...}: {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
        extraConfig = ''
          auth_request https://auth.schwem.io/oauth2/start?rd=https%3A%2F%2Fmonitor.schwem.io&allowed_groups=role:admin;
          include ${config.sops.templates.nginx_allow_secure.path};
        '';

        # extraConfig = ''
        #   auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
        # '';
      };
    };
  };
}
