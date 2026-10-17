{ self, config, ... }: {
  imports = [ self.inputs.hermes-agent.homeManagerModules.default ];

  services.hermes-agent = {
    enable = true;

    workingDirectory = "/home/schwem/.local/share/hermes";

    environmentFiles = [ config.sops.secrets."hermes-agent.env".path ];

    backend = {
      mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
      port = 9119;
    };

    settings = {
      local_runtime = {
        enabled = true;
        backend = "auto";
      };

      model = {
        # NOTE: uncomment for openrouter (default provider)
        # default = "~deepseek/deepseek-v4-flash-latest";

        # # NOTE: uncomment for local config
        # default = "qwen3.8:27b";
        # provider = "custom";
        # base_url = "http://localhost:11434/v1";
      };
    };
  };

  sops.secrets."hermes-agent.env" = {
    format = "dotenv";
    key = "";
    sopsFile = self.lib.secret "nixos" "hermes-agent.env";
  };
}
