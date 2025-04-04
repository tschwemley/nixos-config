{
  self,
  config,
  lib,
  pkgs,
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
            "127.0.0.1:${self.lib.port-map.open-webui}" = {};
          };
        };
      };
    };

    open-webui = {
      enable = true;
      environmentFile = config.sops.templates.open-webui-env.path;
      package = pkgs.open-webui;
      port = lib.strings.toInt self.lib.port-map.open-webui;
    };
  };

  sops = {
    secrets = let
      secretAttrs = {
        sopsFile = "${self.lib.secrets.server}/open-webui.yaml";
      };
    in {
      openwebui_database_url = secretAttrs;
      openwebui_oauth_client_secret = secretAttrs;
      openwebui_openai_api_base_url = secretAttrs;
      openwebui_openai_api_key = secretAttrs;
      openwebui_openid_provider_url = secretAttrs;
      openwebui_openid_redirect_uri = secretAttrs;
      openwebui_secret_key = secretAttrs;
    };

    # using template because of values defined in nix (namely port)
    templates.open-webui-env = let
      inherit (config.sops) placeholder;
    in {
      mode = "0500";
      content =
        /*
        bash
        */
        ''
          # see: https://docs.openwebui.com/getting-started/env-configuration/

          # General
          ENV=prod
          #DATABASE_URL=${placeholder.openwebui_database_url}
          PORT=${self.lib.port-map.open-webui}

          DEFAULT_MODELS=deepseek/deepseek-chat
          #RESET_CONFIG_ON_START=True # resets the config.json file on startup

          WEBUI_SECRET_KEY=${placeholder.openwebui_secret_key};
          WEBUI_SESSION_COOKIE_SECURE=True
          WEBUI_URL=https://ai.schwem.io

          # Auth
          OAUTH_CLIENT_ID=open-webui
          OAUTH_CLIENT_SECRET=${placeholder.openwebui_oauth_client_secret}
          OPENID_PROVIDER_URL=${placeholder.openwebui_openid_provider_url}
          OPENID_REDIRECT_URI=${placeholder.openwebui_openid_redirect_uri}

          # OAUTH_ALLOWED_ROLES=user,admin
          # OAUTH_ADMIN_ROLES=admin
          # OAUTH_EMAIL_CLAIM=email
          # OAUTH_USERNAME_CLAIM=preferred_username
          # OAUTH_MERGE_ACCOUNTS_BY_EMAIL=True
          # OAUTH_SCOPES="openid email profile"

          ENABLE_LOGIN_FORM=False
          ENABLE_OAUTH_SIGNUP=True
          ENABLE_SIGNUP=True

          ENABLE_OAUTH_ROLE_MANAGEMENT=True
          OAUTH_ROLES_CLAIM=resource_access.open-webui.roles

          # Ollama
          ENABLE_OLLAMA_API=False

          # OpenAI
          ENABLE_OPENAI_API=True
          OPENAI_API_BASE_URL=${placeholder.openwebui_openai_api_base_url}
          OPENAI_API_KEY=${placeholder.openwebui_openai_api_key}

          # Text to Speech
          AUDIO_TTS_ENGINE=transformers

          # Image Generation
          # Proxy
          # Speech to Text
          # Tasks
          # Tools
          # RAG
          # Web Search
        '';
    };
  };

  systemd.services.open-webui.path = [pkgs.ffmpeg_headless];
}
