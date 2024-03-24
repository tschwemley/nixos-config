let
  ip = "127.0.0.1";
  port = "4180";
  proxyPass = "http://${ip}:${port}";
in {
  services.nginx.virtualHosts."auth.schwem.io" = {
    locations = {
      "/".extraConfig = ''
        auth_request /oauth2/auth;
        error_page 401 403 = /oauth2/sign_in;

        # pass information via X-User and X-Email headers to backend,
        # requires running with --set-xauthrequest flag
        auth_request_set $user   $upstream_http_x_auth_request_user;
        auth_request_set $email  $upstream_http_x_auth_request_email;
        proxy_set_header X-User  $user;
        proxy_set_header X-Email $email;

        # if you enabled --cookie-refresh, this is needed for it to work with auth_request
        auth_request_set $auth_cookie $upstream_http_set_cookie;
        add_header Set-Cookie $auth_cookie;
      '';

      "/oauth2/" = {
        inherit proxyPass;
        extraConfig = ''
          proxy_set_header X-Scheme                $scheme;
          proxy_set_header X-Auth-Request-Redirect $scheme://$host$request_uri;
        '';
      };

      "/oauth2/auth" = {
        inherit proxyPass;
        extraConfig = ''
          proxy_set_header X-Scheme         $scheme;

          # nginx auth_request includes headers but not body
          proxy_set_header Content-Length   "";
          proxy_pass_request_body           off;
        '';
      };
    };
  };
}
