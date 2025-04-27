{config, ...}: {
  programs.mods = {
    enable = true;
    enableZshIntegration = true;
  };

  sops.templates."mods.yml" = {
    path = "${config.home.homeDirectory}/.config/mods/mods.yml";

    content =
      /*
      yaml
      */
      ''
        default-model: "deepseek-chat"
        # Text to append when using the -f flag.
        format-text:
          markdown: "Format the response as markdown without enclosing backticks."
          json: "Format the response as json without enclosing backticks."
        # List of predefined system messages that can be used as roles.
        roles:
          default:
            - you never use non-english characters in your response
            - you give direct answers to questions about programming languaes and commands without any additional explanation
            - you may ONLY explain/answer fully when explicitly asked by the user in a follow up
            - "for example - for the question \"what is the concatenation operator for php?\" You would simply reply: ."
            - you may use formatting when deemed appropriate to do so (e.g. markdown snippets, backticks, etc.)
            - you do not use overly wordy responses or reword the question back when giving a reply. This is not a standarized test. You are a tool meant to serve one purpose. Be succint.
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
        theme: charm
        # Default character limit on input to model.
        max-input-chars: 12250
        # Maximum number of tokens in response.
        # max-tokens: 100
        # Aliases and endpoints for OpenAI compatible REST API.
        apis:
          schwem-io:
            base-url: https://ai.schwem.io/api
            api-key: ${config.sops.placeholder.open_webui_api_key}
            models:
              deepseek/deepseek-chat-v3-0324:
                aliases: ["deepseek-chat"]
                max-input-chars: 128000
              deepseek/deepseek-r1:
                aliases: ["r1"]
                max-input-chars: 392000
      '';
  };
}
