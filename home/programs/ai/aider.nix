{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      aider-chat
      playwright
    ];

    shellAliases = {
      aider = "aider -c ${config.sops.templates."aider.conf.yml".path}";
    };
  };

  sops.templates."aider.conf.yml".content =
    /*
    see: https://aider.chat/docs/config/aider_conf.html
    yaml
    */
    ''
      model: "openrouter/deepseek/deepseek-r1"
      api-key:
        - openrouter=${config.sops.placeholder.openrouter_api_key}

      ###
      # Other available models:
      ###
      #model: "openrouter/deepseek/deepseek-chat-v3-0324"
    '';
}
