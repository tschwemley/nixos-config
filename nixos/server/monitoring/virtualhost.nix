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
          error_page 401 =403 https://auth.schwem.io/oauth2/start?rd=https://monitor.schwem.io&allowed_groups=role:admin

          auth_request_set $user   $upstream_http_x_auth_request_user;
          auth_request_set $email  $upstream_http_x_auth_request_email;
          proxy_set_header X-User  $user;
          proxy_set_header X-Email $email;

          include ${config.sops.templates.nginx_allow_secure.path};

          # auth_request_set $name_upstream_1 $upstream_cookie__oauth2_proxy_1;
          #
          # access_by_lua_block {
          #   if ngx.var.name_upstream_1 ~= "" then
          #     ngx.header["Set-Cookie"] = "_oauth2_proxy_1=" .. ngx.var.name_upstream_1 .. ngx.var.auth_cookie:match("(; .*)")
          #   end
          # }
          #
          # proxy_set_header Authorization $http_authorization;
          # proxy_set_header X-User $http_x_user;
          #
          # proxy_pass http://libreddit;
        '';

        # extraConfig = ''
        #   auth_request https://auth.schwem.io/oauth2/auth?allowed_groups=role:admin;
        # '';
      };
    };
  };
}
