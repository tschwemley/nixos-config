{ config, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    configDir = "${config.xdg.configHome}/pi/agent";
    models = {
      providers = {
        ollama = {
          api = "openai-completions";
          apiKey = "ollama";
          baseUrl = "http://localhost:11434/v1";
          models = [
            {
              id = "llama3.1:8b";
            }
          ];
        };
      };
    };
  };
}
