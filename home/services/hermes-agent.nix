{ self, config, ... }: {
  imports = [ self.inputs.hermes-agent.homeModules.default ];

  services.hermes-agent = {
    enable = true;

    addToSystemPackages = true;
    environmentFiles = [ config.sops.secrets."hermes-agent.env".path ];

    backend = {
      mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
      port = 9119;
    };

    settings = {
      model.default = "~deepseek/deepseek-v4-flash-latest";
    };
  };

  sops.secrets."hermes-agent.env" = {
    format = "dotenv";
    key = "";
    sopsFile = self.lib.secret "nixos" "hermes-agent.env";
  };
}
