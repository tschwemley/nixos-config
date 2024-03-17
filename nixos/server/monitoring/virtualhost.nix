{config, ...}: {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.port}";
        proxyWebsockets = true;

        # extraConfig = ''
        #   auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
        # '';
      };
    };
  };
}
