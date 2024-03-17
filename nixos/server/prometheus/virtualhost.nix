let
  ip = "127.0.0.1";
  port = "9090";
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${ip}:${port}";
        extraConfig = ''
          auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
        '';
      };
    };
  };
}
