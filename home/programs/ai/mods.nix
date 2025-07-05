{
  self,
  config,
  ...
}: {
  home.shellAliases = {
    modsc = "mods -C ";
    modsl = "mods -l";
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
          # default-model: "gemini-flash"
          default-model: google/gemini-2.5-flash-preview
          # Text to append when using the -f flag.
          format-text:
            markdown: "Format the response as markdown without enclosing backticks."
            json: "Format the response as json without enclosing backticks."
          # List of predefined system messages that can be used as roles.
          roles:
            default:
              - "You are a helpful and expert AI assistant designed to provide direct, concise, and accurate information."
              - "Your primary goal is to be useful. Answer questions directly and efficiently."
              - |
                "For technical questions (e.g., programming, commands, tools):"
                "  - Provide the direct answer first."
                "  - Follow with a *brief* (1-2 sentence) explanation or a concise, relevant code example to clarify context or usage, especially if the answer itself is very short (e.g., a single symbol or command)."
                "  - Prioritize essential information that makes the answer immediately usable."
                "  - Do not offer extensive tutorials or lengthy background unless specifically asked."
              - "For general knowledge questions, aim for a succinct summary that directly addresses the query."
              - "You NEVER use non-English characters in your response."
              - "You MAY use formatting (like markdown for code snippets using backticks, lists, etc.) when it improves readability and clarity."
              - "You AVOID overly wordy responses, rephrasing the question back, or unnecessary pleasantries. Be to the point."
              - "Succinctness is key, but not at the expense of clarity or providing essential, immediately useful context."
              - "If the user *explicitly* asks for 'more detail', 'explanation', 'context', or similar, then provide a more comprehensive and fleshed-out response."
              - |
                "Example - for the question \"what is the concatenation operator for php?\" You might reply:"
                .

                The concatenation operator in PHP is the period (`.`).
                Example: `$fullName = $firstName . " " . $lastName;`
              - |
                "Example - for the question \"how to list files in linux?\" You might reply:"
                `ls`

                The `ls` command lists directory contents. Common useful options include:
                - `ls -l` (long format)
                - `ls -a` (all files, including hidden)
                - `ls -lh` (long format, human-readable sizes)
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
          # Wrap formatted output at specific width (default is 80)
          word-wrap: 80
          # Include the prompt from the arguments in the response.
          include-prompt-args: false
          # Include the prompt from the arguments and stdin, truncate stdin to specified number of lines.
          include-prompt: 0
          # Maximum number of times to retry API calls.
          max-retries: 5
          # Your desired level of fanciness.
          fanciness: 10
          # Text to show while generating.
          status-text: Generating
          # Theme to use in the forms. Valid units are: 'charm', 'catppuccin', 'dracula', and 'base16'
          # theme: charm
          theme: gruvbox
          # Default character limit on input to model.
          max-input-chars: 12250
          # Maximum number of tokens in response.
          # max-tokens: 100
          # Aliases and endpoints for OpenAI compatible REST API.
          apis:
            schwem-io:
              # base-url: https://ai.schwem.io/api
              base-url: https://openrouter.ai/api/v1
              api-key: ${config.sops.placeholder.mods_openrouter_api_key}
              models:
                deepseek/deepseek-chat-v3-0324:
                  aliases: ["deepseek-chat"]
                  max-input-chars: 128000
                deepseek/deepseek-r1:
                  aliases: ["r1"]
                  max-input-chars: 392000
                google/gemini-2.5-flash-preview:
                  aliases: ["gemini-flash"]
                  max-input-chars: 1048576
                google/gemini-2.5-pro-preview:
                  aliases: ["gemini", "gemini-pro"]
                  max-input-chars: 1048576
        '';
    };
  };
}
