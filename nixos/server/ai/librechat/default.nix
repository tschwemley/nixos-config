{
  self,
  config,
  ...
}: {
  imports = [./module.nix];

  services.librechat = {
    enable = true;

    credentials = let
      secretPath = config.sops.secrets.librechat.path;
    in {
      CREDS_KEY = secretPath;
      CREDS_IV = secretPath;
      JWT_KEY = secretPath;
      JWT_REFRESH_KEY = secretPath;
      MEILI_MASTER_KEY = secretPath;
    };

    env = {
      ALLOW_REGISTRATION = "false";
      HOST = "127.0.0.1";
    };

    # NOTE: settings is free-form nix attribute set that will be converted to librechat.yaml
    settings = {};
  };

  sops.secrets = {
    librechat = {
      owner = config.services.librechat.user;
      group = config.services.librechat.user;
      mode = "0400";

      format = "dotenv";
      sopsFile = self.lib.secret "server" "librechat-creds.env";
    };
  };
}
