local null_ls = require("null-ls")
null_ls.setup({
   sources = {
      null_ls.builtins.formatting.alejandra,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.gofmt,
      -- null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.golines.with({
         extra_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
         },
      }),
   },
})
