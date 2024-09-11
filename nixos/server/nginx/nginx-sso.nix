{ config, pkgs, ... }:
let
  pkg = pkgs.nginx-sso;
  sopsInfo = {
    mode = "444";
    sopsFile = ./secrets.yaml;
  };
in
{
  services.nginx.virtualHosts."auth.schwem.io" = {
    extraConfig = "error_page 401 = @error401;";

    locations = {
      "/auth" = {
        proxyPass = "http://articuno:${config.portMap.nginx-sso}/auth";
        extraConfig = ''
          internal;

          proxy_pass_request_body off;
          proxy_set_header Content-Length "";
          proxy_set_header X-Origin-URI $request_uri;
        '';
      };

      "/logout".return = "302 https://auth.schwem.io/login?go=$scheme://$http_host$request_uri";

      "@error401".return = "302 https://auth.schwem.io/login?go=$scheme://$http_host$request_uri";
    };
  };

  systemd.services.nginx-sso = {
    description = "Nginx SSO Backend";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkg}/bin/nginx-sso \
          --config ${config.sops.templates.nginx_sso_config.path} \
          --frontend-dir ${pkg}/share/frontend
      '';
      Restart = "always";
      DynamicUser = true;
    };
  };

  sops = {
    secrets = {
      nginx_sso_acl = sopsInfo;
      nginx_sso_auth_key = sopsInfo;
      nginx_sso_client_secret = sopsInfo;
    };

    templates.nginx_sso_config = {
      mode = "444";
      content = # yaml
        ''
          cookie:
            domain: ".schwem.io"
            authentication_key: ${config.sops.placeholder.nginx_sso_auth_key}
            expire: 3600        # Optional, default: 3600
            secure: true        # Optional, default: false

          listen:
            addr: "127.0.0.1"
            port: ${config.portMap.nginx-sso}

          providers:
            oidc:
              client_id: "nginx-sso"
              client_secret: "${config.sops.placeholder.nginx_sso_client_secret}"
              redirect_url: "https://auth.schwem.io/login"
              # Optional, defaults to "OpenID Connect"
              issuer_name: "schwem-io"
              issuer_url: "https://auth.schwem.io/realms/schwem-io"

              # Optional, defaults to no limitations
              require_domain: "schwem.io"
              # Optional, defaults to "user-id"
              # user_id_method: "full-email"

          ${config.sops.placeholder.nginx_sso_acl}
        '';
    };
  };
}
