{ config, ... }:
{
  services.nginx.virtualHosts."dash.schwem.io" = {
    extraConfig = ''
      error_page 401 = @error401;
    '';

    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:${config.portMap.dashboard}";
        extraConfig = ''
          auth_request .auth;
        '';
      };

      ".auth" = {
        proxyPass = "http://127.0.0.1:${config.portMap.oidc-sso}/auth";
        extraConfig = ''
          internal;
        '';
      };

      "@error401".return = "302 https://auth.schwem.io/login?rd=https://dash.schwem.io";
    };
  };
}
