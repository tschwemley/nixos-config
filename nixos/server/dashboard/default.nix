{ config, ... }:
{
  services.nginx.virtualHosts."dash.schwem.io".locations = {
    extraConfig = ''
      error_page 401 = @error401;
    '';

    "/" = {
      proxyPass = "http://localhost:6969";
      extraConfig = ''
        auth_request .auth;
      '';
    };

    ".auth" = {
      proxyPass = "http://localhost:${config.portMap.oidc-sso}/check-token";
      extraConfig = ''
        internal;
      '';
    };

    "@error401".return = "302 https://auth.schwem.io/login?rd=https://dash.schwem.io";
  };
}
