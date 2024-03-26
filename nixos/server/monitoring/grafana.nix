# TODO: setup w/ cockroachdb. By default it's using sqlite
{config, ...}: {
  services.grafana = {
    enable = true;
    settings = {
      "auth.generic_oauth" = {
        enabled = true;
        name = "keycloak";

        api_url = "https://auth.schwem.io/realms/schwem-io/protocol/openid-connect/userinfo";
        auth_url = "https://auth.schwem.io/realms/schwem-io/protocol/openid-connect/auth";
        client_id = "grafana";
        client_secret = "$__file{${config.sops.secrets.grafana_oauth_client_secret.path}}";
        email_attribute_path = "email";
        login_attribute_path = "username";
        name_attribute_path = "full_name";
        role_attribute_path = "contains(roles[*], 'admin') && 'Admin'";
        scopes = "openid email profile offline_access roles";
        signout_redirect_url = "https://auth.schwem.io/auth/realms/schwem-io/protocol/openid-connect/logout?post_logout_redirect_uri=https%3A%2F%2Fmonitor.schwem.io%2Flogin";
        token_url = "https://auth.schwem.io/realms/schwem-io/protocol/openid-connect/token";
        use_refresh_token = true;
      };

      server = {
        domain = "monitor.schwem.io";
        http_addr = "127.0.0.1";
        http_port = 3000;
      };
    };
  };

  sops.secrets.grafana_oauth_client_secret = {
    sopsFile = ./secrets.yaml;
    group = config.users.users.grafana.group;
    owner = config.users.users.grafana.name;
  };
}
