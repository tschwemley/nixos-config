{config, ...}: let
  ip = "127.0.0.1";
  port = toString config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${ip}:${port}";
        proxyWebsockets = true;
        extraConfig = ''
          auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
          error_page 401 =403 http://${ip}:${port}/oauth2/start?rd=https://monitor.schwem.io&allowed_groups=role:admin;

          auth_request_set $user   $upstream_http_x_auth_request_user;
          auth_request_set $email  $upstream_http_x_auth_request_email;
          proxy_set_header X-User  $user;
          proxy_set_header X-Email $email;

          auth_request_set $auth_cookie $upstream_http_set_cookie;
          add_header Set-Cookie $auth_cookie;

          # When using the --set-authorization-header flag, some provider's cookies can exceed the 4kb
          # limit and so the OAuth2 Proxy splits these into multiple parts.
          # Nginx normally only copies the first `Set-Cookie` header from the auth_request to the response,
          # so if your cookies are larger than 4kb, you will need to extract additional cookies manually.
          auth_request_set $auth_cookie_name_upstream_1 $upstream_cookie_auth_cookie_name_1;

          # Extract the Cookie attributes from the first Set-Cookie header and append them
          # to the second part ($upstream_cookie_* variables only contain the raw cookie content)
          if ($auth_cookie ~* "(; .*)") {
              set $auth_cookie_name_0 $auth_cookie;
              set $auth_cookie_name_1 "auth_cookie_name_1=$auth_cookie_name_upstream_1$1";
          }

          # Send both Set-Cookie headers now if there was a second part
          if ($auth_cookie_name_upstream_1) {
              add_header Set-Cookie $auth_cookie_name_0;
              add_header Set-Cookie $auth_cookie_name_1;
          }

          include ${config.sops.templates.nginx_allow_secure.path};
        '';

        # extraConfig = ''
        #   auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
        # '';
      };
    };
  };
}
