let
  ip = "127.0.0.1";
  port = "4180";

  backendUrl = "http://${ip}:${port}";
  proxyPass = "${backendUrl}";
in {
  services.nginx.virtualHosts."auth.schwem.io" = {
    # TODO: remove if this doesn't need to be set
    # extraConfig = ''
    #   large_client_header_buffers  4 32k;
    #   proxy_buffer_size  32k;
    # '';

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

        # When using the --set-authorization-header flag, some provider's cookies can exceed the 4kb
        # limit and so the OAuth2 Proxy splits these into multiple parts.
        # Nginx normally only copies the first `Set-Cookie` header from the auth_request to the response,
        # so if your cookies are larger than 4kb, you will need to extract additional cookies manually.
        # auth_request_set $auth_cookie_name_upstream_1 $upstream_cookie_auth_cookie_name_1;

        # Extract the Cookie attributes from the first Set-Cookie header and append them
        # to the second part ($upstream_cookie_* variables only contain the raw cookie content)
        # if ($auth_cookie ~* "(; .*)") {
        #     set $auth_cookie_name_0 $auth_cookie;
        #     set $auth_cookie_name_1 "auth_cookie_name_1=$auth_cookie_name_upstream_1$1";
        # }
        #
        # # Send both Set-Cookie headers now if there was a second part
        # if ($auth_cookie_name_upstream_1) {
        #     add_header Set-Cookie $auth_cookie_name_0;
        #     add_header Set-Cookie $auth_cookie_name_1;
        # }
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
