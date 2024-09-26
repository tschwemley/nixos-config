{ config, ... }:
{
  services.nginx.virtualHosts."dash.schwem.io" = {
    extraConfig = ''
      error_page 401 = @error401;
    '';

    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:6969";
        extraConfig = ''
          auth_request .auth;
        '';
      };

      ".auth" = {
        proxyPass = "http://127.0.0.1:${config.portMap.oidc-sso}/check-token";
        extraConfig = ''
          internal;
        '';
      };

      "@error401".return = "302 https://auth.schwem.io/login?rd=https://dash.schwem.io";
    };
  };
}
