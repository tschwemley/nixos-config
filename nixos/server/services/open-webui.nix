{
  config,
  secretsPath,
  ...
}: {
  services.open-webui = {
    enable = true;
    environmentFile = config.sops.templates.open-webui-env.path;
    # environment = {
    #   ANONYMIZED_TELEMETRY = "False";
    #   DO_NOT_TRACK = "True";
    #   SCARF_NO_ANALYTICS = "True";
    # };
  };

  sops = {
    secrets = let
      secretAttrs = {
        sopsFile = "${secretsPath}/server/open-webui.yaml";
      };
    in {
      oauth_client_secret = secretAttrs;
    };

    templates.open-webui-env = {
      mode = "0500";
      content =
        /*
        dotenv
        */
        ''
          ENABLE_OAUTH_SIGNUP=true
          OAUTH_CLIENT_ID=open-webui
          OAUTH_CLIENT_SECRET=${config.sops.placeholder.oauth_client_secret}
          OPENID_PROVIDER_URL=https://auth.schwem.io/realms/schwem-io/.well-known/openid-configuration
          OPENID_REDIRECT_URL=https://ai.schwem.io/
        '';
    };
  };
}
