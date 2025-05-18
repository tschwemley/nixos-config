{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # aider-chat-with-browser
      aider-chat-with-playwright
      # aider-chat-full
      playwright
    ];

    shellAliases = {
      aider = "aider -c ${config.sops.templates."aider.conf.yml".path} --model-settings-file ${config.xdg.dataFile."aider/.aider.model.settings.yml".source}";
    };
  };

  # REF: https://aider.chat/docs/config/aider_conf.html
  sops.templates."aider.conf.yml".content =
    # model: "openrouter/deepseek/deepseek-chat-v3-0324"
    /*
    yaml
    */
    ''
      # --------------------
      # Core Settings
      # --------------------
      api-key:
        - openrouter=${config.sops.placeholder.openrouter_api_key}

      # --------------------
      # Model Settings
      # --------------------
      alias:
        - gemini:openrouter/google/gemini-2.5-pro-preview
        - deepseek-chat:openrouter/deepseek/deepseek-chat-v3-0324
        - deepseek-chat-free:openrouter/deepseek/deepseek-chat-v3-0324:free
        - deepseek-r1:openrouter/deepseek/deepseek-r1
        - deepseek-r1-free:openrouter/deepseek/deepseek-r1:free
      model: "gemini"

      # --------------------
      # Appearance Settings
      # --------------------
      code-theme: gruvbox-dark
      pretty: true
      stream: true

      ## All colors are based off Gruvbox Dark Material Hard
      assistant-output-color: "#7daea3"  # Blue

      completion-menu-color: "#d4be98"   # Foreground
      completion-menu-bg-color: "#1d2021" # Background
      completion-menu-current-color: "#3C3836" # Selection foreground
      completion-menu-current-bg-color: "#D4BE98" # Selection background

      tool-output-color: "#89b482"  # Foreground
      tool-error-color: "#ea6962"   # Bright Red
      tool-warning-color: "#d8a657" # Yellow

      user-input-color: "#d4Be98"  # Foreground (gray)
    '';

  xdg.dataFile."aider/.aider.model.settings.yml".text =
    /*
    yaml
    */
    ''
      - name: "(default values)"
        edit_format: whole
        weak_model_name: null
        use_repo_map: false
        send_undo_reply: false
        lazy: false
        overeager: false
        reminder: user
        examples_as_sys_msg: false
        extra_params: null
        cache_control: false
        caches_by_default: false
        use_system_prompt: true
        use_temperature: true
        streaming: true
        editor_model_name: null
        editor_edit_format: null
        reasoning_tag: null
        remove_reasoning: null
        system_prompt_prefix: null
        accepts_settings: null

      - name: openrouter/google/gemini-2.5-pro-preview-03-25
        edit_format: diff-fenced
        weak_model_name: openrouter/google/gemini-2.0-flash-001
        use_repo_map: true
    '';
}
