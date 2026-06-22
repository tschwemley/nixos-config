{
  self,
  config,
  ...
}:
{
  home = {
    sessionVariables = {
      OPENROUTER_API_KEY = "$(cat ${config.sops.secrets.mods_openrouter_api_key.path})";
    };

    shellAliases = {
      modsc = "mods -C ";
      modsl = "mods -l ";
    };
  };

  programs.mods = {
    enable = true;
    enableZshIntegration = true;
  };

  sops = {
    secrets.mods_openrouter_api_key = {
      key = "openrouter_api_key_mods";
      mode = "0400";
      sopsFile = self.lib.secret "home" "ai.yaml";
    };

    templates."mods.yml" = {
      path = "${config.home.homeDirectory}/.config/mods/mods.yml";

      content =
        # yaml
        ''
          default-model: gemini-3-flash-preview
          format-text:
            markdown: "Format the response as markdown without enclosing backticks."
            json: "Format the response as json without enclosing backticks."
          # List of predefined system messages that can be used as roles.
          roles:
            default:
              - You are a highly skilled, concise, and efficient AI assistant focused on delivering precise, actionable information.
              - Prioritize being **useful above all**—provide direct answers first, with minimal but sufficient supporting context.
              - |
                  "For technical queries (e.g., programming, CLI commands, tools):"
                  "  - Begin with the exact answer or command needed."
                  "  - Include a brief explanation (1–2 sentences) or minimal code snippet *only if necessary* to clarify usage or behavior."
                  "  - Emphasize critical flags, syntax, or distinctions if the answer might be ambiguous or error-prone."
                  "  - Avoid verbosity, tutorials, or conceptual overviews unless explicitly requested."
              - For factual or general knowledge questions, provide a succinct summary that fully resolves the query.
              - Use **English only** in all responses.
              - Use **Markdown formatting** (e.g., backticks for code, bullet points, headers) to improve readability when helpful.
              - Avoid restating the question, pleasantries, filler text, or hedging language. Be direct and confident.
              - Strive for **maximum utility per token**—clear, compact, and immediately actionable responses.
              - If the user explicitly asks for more context, explanation, examples, or elaboration, then provide a more detailed and structured response.
              - |
                  "Examples:"
                  "  - Q: \"What is the concatenation operator in PHP?\""
                  "    A: `.`"
                  "       Used to join strings: `$greeting = \"Hello, \" . $name;`"
                  "  - Q: \"How to list files in Linux?\""
                  "    A: `ls`"
                  "       Common options:"
                  "       - `-l`: long format"
                  "       - `-a`: include hidden files"
                  "       - `-lh`: human-readable sizes"

          # System role to use.
          role: "default"

          # # Render output as raw text when connected to a TTY.
          # raw: false

          # # Ask for the response to be formatted as markdown unless otherwise set.
          # format: false

          # Quiet mode (hide the spinner while loading and stderr messages for success).
          quiet: false

          # Temperature (randomness) of results, from 0.0 to 2.0.
          temp: 1.0

          # TopP, an alternative to temperature that narrows response, from 0.0 to 1.0.
          topp: 1.0

          # TopK, only sample from the top K options for each subsequent token.
          topk: 50

          # Turn off the client-side limit on the size of the input into the model.
          no-limit: false

          word-wrap: 80
          include-prompt-args: false
          include-prompt: 0
          max-retries: 5
          fanciness: 10
          status-text: Generating
          theme: gruvbox
          # max-input-chars: 12250

          apis:
            schwem-io:
              base-url: https://openrouter.ai/api/v1
              api-key: ${config.sops.placeholder.mods_openrouter_api_key}
              models:
                anthropic/claude-opus-4.5:
                  aliases: ["claude-opus-4.5"]
                  max-input-chars: 640000
                google/gemini-3-flash-preview:
                  aliases: ["gemini-3-flash-preview"]
                  max-input-chars: 1048576
                  
        '';
    };
  };
}
