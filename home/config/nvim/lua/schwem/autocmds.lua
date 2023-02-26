local autocmd = vim.api.nvim_create_autocmd
-- local afterlua = vim.env.HOME .. "/.config/nvim/after"
local schwemlua = vim.env.HOME .. "/.config/lua/"

-- Automatically source lua files on save
autocmd(
  'BufWritePost',
  {
    pattern = schwemlua .. "/*",
    command = 'source ' .. vim.env.MYVIMRC
  }
)

-- TODO: fix
-- autocmd(
--   'BufWritePost',
--   {
--     pattern = afterlua .. "/*",
--     command = "source %"
--   }
-- )
