local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
   sources = {
      --go
      null_ls.builtins.code_actions.gomodifytags,
      null_ls.builtins.code_actions.impl,

      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.golines.with({
         extra_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
         },
      }),

      --lua
      null_ls.builtins.formatting.stylua,

      --multiple
      null_ls.builtins.formatting.prettierd,

      --nix
      null_ls.builtins.diagnostics.deadnix,
      null_ls.builtins.diagnostics.statix,

      null_ls.builtins.formatting.nixfmt,

      -- other
      null_ls.builtins.hover.printenv.with({
         filetypes = { "sh", "zsh" },
      }),
   },

   on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
         -- TODO: this clears the previously defined LspFormat capabilities. Probably delete... but keep around for
         -- a short while to ensure no issues with double formatting on configured lsps [09/11/24]
         -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               vim.lsp.buf.format({ async = false })
            end,
         })
      end
   end,
})
