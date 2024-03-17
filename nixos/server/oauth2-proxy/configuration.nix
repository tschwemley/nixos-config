{config, ...}: {
  sops.secrets = {
    oauth2_proxy_client_secret = {
      sopsFile = ./secrets.yaml;
      mode = "444";
    };
    oauth2_proxy_cookie_secret = {
      sopsFile = ./secrets.yaml;
      mode = "444";
    };
  };

  sops.templates.oauth2_proxy_env.content = ''
    OAUTH2_PROXY_CLIENT_SECRET=${config.sops.placeholder.oauth2_proxy_client_secret}
    OAUTH2_PROXY_COOKIE_SECRET=${config.sops.placeholder.oauth2_proxy_cookie_secret}
    OAUTH2_PROXY_OIDC_ISSUER_URL=https://auth.schwem.io/realms/schwem-io
  '';
}
