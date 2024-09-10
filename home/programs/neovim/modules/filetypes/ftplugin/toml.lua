vim.api.nvim_create_autocmd("BufWritePre", {
   -- pattern = { "*.toml" },
   buffer = 0,
   callback = function()
      vim.lsp.buf.format({ async = false })
   end,
})
