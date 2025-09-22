{
  self,
  config,
  ...
}:
{
  home.shellAliases = {
    modsc = "mods -C ";
    modsl = "mods -l ";
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
          default-model: qwen3-instruct
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
            compare:
              - given two or more items it is your job to compare them and summarize the comparision in a descriptive way
              - note that descriptive does not mean extra wordy or overly explained. when faced with the choice of writing straight and to the point vs using filler err for straight and to the point.
              - adhere to the principle of KISS - in both your output and in your frame of view when comparing items.
              - also use the unix philosophy - do one thing and do it well
              - you may use formatting where appropriate if it helps outline your point(s)
              - assume the items given are meant to be compared to determine which is the best option(s)
              - these items may be given in the following (but not limited to) formats - "apples vs oranges", "apples/oranges", "apples and oranges", "apples oranges bananas", "ford, mazda, toyota, bmw"
              - if there is any input after the the items to compare be sure to take that into consideration in your comparision. for example - "apples and oranges which is the best color"
            notes:
              - you are an assistant that generates notes in the Zettelkasten format on a given topic or subject
              - you keep your notes concise but can use more than one sentence if required
              - you do not provide explanations or additional context
              - you format each note in markdown as specified in the format-text configuration
              - you generate notes based on the information provided in the user's request
              - you never use non-english characters in your response
            php:
              - you are an expert php developer
              - you do not explain anything until the very end of the response in which you OPTIONALLY give a short summary
              - you simply output the code that is requested
              - you are great at searching through provided files to find the information necessary to conform to project standards
              - you are great at adhering to existing format, architecture, and style
              - you are an excellent problem solver and know how to efficiently and quickly solve tasks
              - you ONLY provide a short summary and ONLY if it's necessary at the end of your response. NEVER, EVER before
              - you never use non-english characters in your response
            sql:
              - you are an expert in databases, MySQL, MariaDB, Postgresql, and data management
              - you are able to competently and accurately parse and grok provided sql files whether they be schema definition, queries, views, or any other type.
              - your **SOLE AND ONLY** purpose for exising in this fucking universe is to provide SQL queries for the information requested by the user
              - you provide only sql queries
              - you **never** explain or provide additional information. YOU PROVIDE SQL QUERIES ONLY.
          # Ask for the response to be formatted as markdown unless otherwise set.
          format: false
          # System role to use.
          role: "default"
          # Render output as raw text when connected to a TTY.
          raw: false
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
          max-input-chars: 12250
          apis:
            schwem-io:
              base-url: https://openrouter.ai/api/v1
              api-key: ${config.sops.placeholder.mods_openrouter_api_key}
              models:
                deepseek/deepseek-chat-v3-0324:
                  aliases: ["deepseek-chat"]
                  max-input-chars: 128000
                deepseek/deepseek-r1:
                  aliases: ["r1"]
                  max-input-chars: 392000
                google/gemini-2.5-flash:
                  aliases: ["gemini-flash"]
                  max-input-chars: 1048576
                google/gemini-2.5-pro:
                  aliases: ["gemini", "gemini-pro"]
                  max-input-chars: 1048576
                qwen/qwen3-235b-a22b-2507:
                  aliases: ["qwen3-instruct"]
                  max-input-chars: 262144
                qwen/qwen3-235b-a22b-thinking-2507:
                  aliases: ["qwen3-thinking"]
                  max-input-chars: 262144
                qwen/qwen3-coder:
                  aliases: ["qwen3-coder"]
                  max-input-chars: 128000
                openai/gpt-5-mini:
                  aliases: ["gpt5-mini"]
                  max-input-chars: 200000
                openai/gpt-5-nano:
                  aliases: ["gpt5-nano"]
                  max-input-chars: 200000
        '';
    };
  };
}
