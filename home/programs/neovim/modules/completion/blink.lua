-- REF: https://cmp.saghen.dev/configuration/general.html
require("blink.cmp").setup({
   keymap = { preset = "super-tab" },
   signature = { enabled = true }, -- signature.window.show_documentation = false to only show the signature, and not the documentation
   snippets = { preset = "luasnip" },

   -- use mini.icons in the completion menu
   completion = {
      menu = {
         draw = {
            components = {
               kind_icon = {
                  text = function(ctx)
                     local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                     return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                     local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                     return hl
                  end,
               },
               kind = {
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                     local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                     return hl
                  end,
               },
            },
         },
      },
   },

   sources = {
      default = { "buffer", "emoji", "lsp", "path", "snippets" },

      per_filetype = {
         lua = { "buffer", "lazydev", "lsp", "snippets" },
         sql = { "buffer", "dadbod", "snippets" },
      },

      providers = {
         dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
         css_vars = { name = "css-vars", module = "css-vars.blink" },
         env = { name = "Env", module = "blink-cmp-env" },
         lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },

         emoji = {
            name = "Emoji",
            module = "blink-emoji",
            should_show_items = function()
               return vim.tbl_contains(
               -- Enable emoji completion only for git commits and markdown.
                  { "gitcommit", "markdown" },
                  vim.o.filetype
               )
            end,
         },
      },
   },
})
