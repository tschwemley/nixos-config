local codecompanion = require("codecompanion")

-- local secret_path = "~/.config/sops-nix/secrets"
codecompanion.setup({
   adapters = {
      anthropic = function()
         return require("codecompanion.adapters").extend("anthropic", {
            env = {
               api_key = "cmd:sops -d --extract '[\"anthropic_api_key\"]' ~/nixos-config/home/secrets.yaml 2>/dev/null",
            },
         })
      end,

      ollama = function()
         return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
            schema = {
               model = {
                  default = "codestral:22b-v0.1-q8_0",
                  choices = {
                     "codestral:22b-v0.1-q8_0",
                     "qwen2.5-coder:7b-instruct-q8_0",
                     "qwen2.5-coder:32b",
                  },
               },
            },
         })
      end,

      groq = function()
         return require("codecompanion.adapters").extend("openai", {
            env = {
               api_key = "cmd:sops -d --extract '[\"groq_api_key\"]' ~/nixos-config/home/secrets.yaml 2>/dev/null",
            },
            name = "Groq",
            url = "https://api.groq.com/openai/v1/chat/completions",
            schema = {
               model = {
                  default = "llama3-groq-70b-8192-tool-use-preview",
                  choices = {
                     "gemma-7b-it",
                     "gemma2-9b-it",
                     "llama3-groq-70b-8192-tool-use-preview",
                     "llama3-groq-8b-8192-tool-use-preview",
                     "llama3.1-70b-versatile",
                     "llama3.1-8b-instant",
                     "llama3.2-1b-preview",
                     "llama3.2-3b-preview",
                     "mixtral-8x7b-32768",
                  },
               },
            },
            max_tokens = {
               default = 8192,
            },
            temperature = {
               default = 1,
            },
            handlers = {
               -- form_messages = function(self, messages)
               form_messages = function(_, messages)
                  for _, msg in ipairs(messages) do
                     -- Remove 'id' and 'opts' properties from all messages
                     msg.id = nil
                     msg.opts = nil

                     -- Ensure 'name' is a string if present, otherwise remove it
                     if msg.name then
                        msg.name = tostring(msg.name)
                     else
                        msg.name = nil
                     end

                     -- Ensure only supported properties are present
                     local supported_props = { role = true, content = true, name = true }
                     for prop in pairs(msg) do
                        if not supported_props[prop] then
                           msg[prop] = nil
                        end
                     end
                  end
                  return { messages = messages }
               end,
            },
         })
      end,
   },

   strategies = {
      chat = {
         adapter = "codestral",
      },
      inline = {
         adapter = "codestral",
      },
      tool = {
         adapter = "coestral",
      },
   },
})

vim.keymap.set("n", "<leader>ca", codecompanion.actions, { noremap = true })
vim.keymap.set("n", "<leader>cc", codecompanion.chat, { noremap = true })
vim.keymap.set("n", "<leader>ct", codecompanion.toggle, { noremap = true })
