{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      aider-chat-with-browser
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
      api-key:
        - openrouter=${config.sops.placeholder.openrouter_api_key}
      model: "openrouter/deepseek/deepseek-chat-v3-0324"

      # --------------------
      # Appearance Settings

      code-theme: gruvbox-dark
      dark-mode: true
    '';
}
