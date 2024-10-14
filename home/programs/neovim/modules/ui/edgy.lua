-- NOTE: great example config here:
-- https://github.com/willothy/nvim-config/blob/main/lua/configs/ui/edgy.lua

-- views can only be fully collapsed with the global statusline
vim.o.laststatus = 3

-- Default splitting will cause main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.o.splitkeep = "screen"

local function get_height()
   return math.floor((vim.o.lines / 3.5) + 0.5)
end

require("edgy").setup({
   bottom = {
      {
         ft = "dapui_console",
         title = "Debug Console",
         wo = { winbar = " Debug Console" },
         open = function()
            require("dapui").open()
         end,
      },
      {
         ft = "dap-repl",
         title = "Debug REPL",
         wo = { winbar = false, statuscolumn = "" },
         open = function()
            require("dapui").open()
         end,
      },
   },

   left = {
      {
         ft = "dapui_watches",
         wo = { winbar = " Watches" },
         open = function()
            require("dapui").open()
         end,
      },
      {
         ft = "dapui_stacks",
         wo = { winbar = " Stacks" },
         open = function()
            require("dapui").open()
         end,
      },
      {
         ft = "dapui_breakpoints",
         wo = { winbar = " Breakpoints" },
         open = function()
            require("dapui").open()
         end,
      },
      {
         ft = "dapui_scopes",
         wo = { winbar = " Scopes" },
         size = { height = get_height },
         open = function()
            require("dapui").open()
         end,
      },
   },

   -- for codecompanion
   right = {
      { ft = "codecompanion", title = "Code Companion Chat", size = { width = 0.45 } },
   },
})
