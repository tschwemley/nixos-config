{ config, pkgs, ... }:
let
  pkg = pkgs.nginx-sso;
in
{
  systemd.services.nginx-sso = {
    description = "Nginx SSO Backend";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkg}/bin/nginx-sso \
          --config ${config.sops.templates.nginx-sso-config.path} \
          --frontend-dir ${pkg}/share/frontend
      '';
      Restart = "always";
      DynamicUser = true;
    };
  };

  sops = {
    secrets.nginx_sso_auth_key = {
      sopsFile = ./secrets.yaml;
    };

    templates.nginx_allow_secure = {
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
      group = "nginx";
      owner = "nginx";
    };
  };
}
