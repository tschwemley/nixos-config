require("schwem.helpers").set_tabs(2)

-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--    pattern = { '*.nix' },
--    command = ':sil%!nix fmt -- -qq 2&>/dev/null'
-- })
vim.api.nvim_create_autocmd("BufWritePost", {
   pattern = { "*.nix" },
   callback = function()
      vim.lsp.buf.format()
   end,
})
