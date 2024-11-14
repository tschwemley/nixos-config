{
  config,
  lib,
  secretsPath,
  ...
}: {
  services = {
    nginx = {
      virtualHosts."ai.schwem.io".locations = {
        "/" = {
          proxyPass = "http://open-webui";
          proxyWebsockets = true;
        };
      };

      upstreams = {
        "open-webui" = {
          servers = {
            "127.0.0.1:${config.portMap.open-webui}" = {};
          };
        };
      };
    };

    open-webui = {
      enable = true;
      environmentFile = config.sops.templates.open-webui-env.path;
      port = lib.strings.toInt config.portMap.open-webui;
    };
  };

  sops = {
    secrets = let
      secretAttrs = {
        sopsFile = "${secretsPath}/server/open-webui.yaml";
      };
    in {
      openwebui_database_url = secretAttrs;
      openwebui_oauth_client_secret = secretAttrs;
      openwebui_openid_provider_url = secretAttrs;
      openwebui_openid_redirect_uri = secretAttrs;
    };

    templates.open-webui-env = {
      mode = "0500";
      content =
        /*
        bash
        */
        ''
          # see: https://docs.openwebui.com/getting-started/env-configuration/

          # General
          ENV=prod
          WEBUI_URL=https://ai.schwem.io
          ENABLE_SIGNUP=False
          ENABLE_LOGIN_FORM=False
          DEFAULT_MODELS=
          #DATABASE_URL=${config.sops.placeholder.openwebui_database_url}
          PORT=${config.portMap.open-webui}

          # Oauth
          ENABLE_OAUTH_ROLE_MANAGEMENT=true
          ENABLE_OAUTH_SIGNUP=true
          OAUTH_CLIENT_ID=open-webui
          OAUTH_CLIENT_SECRET=${config.sops.placeholder.openwebui_oauth_client_secret}
          OPENID_PROVIDER_URL=${config.sops.placeholder.openwebui_openid_provider_url}
          OPENID_REDIRECT_URI=${config.sops.placeholder.openwebui_openid_redirect_uri}

          # Ollama
          ENABLE_OLLAMA_API=False

          # OpenAI
          # Tasks
          # RAG
          # Web Search
          # Speech to Text
          # Text to Speech
          # Image Generation
          # Tools
          # Proxy
        '';
    };
  };
}
