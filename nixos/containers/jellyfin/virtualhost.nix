{config, ...}: {
  services.nginx.virtualHosts."jellyfin.schwem.io" = {
    locations = {
      "/" = {
        proxyPass = "http://10.10.3.2:8096";
        extraConfig = ''
          auth_request /auth;
          error_page 401 =403 /sign-in;
        '';
      };

      "/auth" = {
        proxyPass = "http://articuno:4180/oauth2/auth?allowed_groups=role:admin";
        extraConfig = "internal;";
      };

      "/sign-in" = {
        proxyPass = "http://articuno:4180/oauth2/start?rd=https%3A%2F%jellyfin.schwem.io&allowed_groups=role:admin";
      };
    };
  };
}
