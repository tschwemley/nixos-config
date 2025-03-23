--
-- This file contains mini modules with minimal to no deviation from the default setup config
--

-- Appearance
require("mini.icons").setup()
require("mini.visits").setup()

-- Text Editing
require("mini.align").setup()
require("mini.move").setup()
require("mini.pairs").setup()

-- TODO: still unsure if I want to use statusline (sl) or lualine (ll)... atm leaning towards ll.
--       startuptime is trivially more performant for sl (.33 vs .53 - aka doesn't fucking matter)
--       I like ll stylization+config slightly more. however, config via function in sl is appealing
--
-- require("mini.statusline").setup({
--    content = {
--       active = function()
--          -- *This* is the place that gets adjusted
--          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 100 })
--          local git = MiniStatusline.section_git({ trunc_width = 40 })
--          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
--          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
--          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
--          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
--          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
--          local location = MiniStatusline.section_location({ trunc_width = 75 })
--          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
--
--          return MiniStatusline.combine_groups({
--             { hl = mode_hl,                 strings = { mode } },
--             { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
--             "%<", -- Mark general truncate point
--             { hl = "MiniStatuslineFilename", strings = { filename } },
--             "%=", -- End left alignment
--             { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
--             { hl = mode_hl,                  strings = { search, location } },
--          })
--       end,
--    },
--    use_icons = true,
--    set_vim_settings = false,
-- })

-- General WorkFlow
-- require("mini.diff").setup({
-- 	view = {
-- 		style = "sign",
-- 	},
-- })
