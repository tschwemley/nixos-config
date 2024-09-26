{
  services.nginx.virtualHosts."dash.schwem.io".locations = {
    "/" = {
      proxyPass = "http://localhost:6969";
      # extraConfig = ''
      #   auth_request .auth;
      # '';
    };

    # ".auth" = {
    #   proxyPass = "http://localhost:1337/auth";
    #   extraConfig = ''
    #     internal;
    #   '';
    # };
    #
    # "@error401".return = "302 https://auth.schwem.io/realms/schwem-io/protocol/openid-connect/auth?response_type=code&state=6EHsAFxgB43c8UXtz825aQ&code_challenge=kEvJguUuaDR6c3k0YBNQFi4YwpFcO1d4x9Us6hIipi0&code_challenge_method=S256&client_id=jellyfin&scope=openid profile&redirect_uri=https://jellyfin.schwem.io/sso/OID/redirect/keycloak";
  };
}
