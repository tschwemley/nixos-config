require("helpers").set_tabs(2)

vim.lsp.enable("superhtml")

-- If you want to disable HTML support for another HTML LSP, add the following
-- to your configuration:
-- >lua
--   vim.lsp.config('superhtml', {
--     filetypes = { 'superhtml' }
--   })
