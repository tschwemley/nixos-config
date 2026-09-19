{ self, config, ... }: {
  imports = [ self.inputs.hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    settings.model.default = "~deepseek/deepseek-v4-flash-latest";
    environmentFiles = [ config.sops.secrets."hermes-agent.env".path ];
    addToSystemPackages = true;

    backend.mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
    backend.port = 9119;
  };

  sops.secrets."hermes-agent.env" = {
    format = "dotenv";
    key = "";
    sopsFile = self.lib.secret "nixos" "hermes-agent.env";
  };
}
