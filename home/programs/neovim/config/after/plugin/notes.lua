require('neorg').setup {
   load = {
      ['core.defaults'] = {},
      ['core.completion'] = {
         config = {
            engine = 'nvim-cmp',
         },
      },
      ['core.concealer'] = {
         config = {
            folds = true
         },
      },
      ['core.dirman'] = {
         config = {
            workspaces = {
               notes = '~/notes',
            },
         }
      },
      ["core.integrations.telescope"] = {},
   }
}

vim.api.nvim_create_user_command('Journal', 'Neorg journal', {})
-- example neorg telescope keybindings mappings
-- local neorg_callbacks = require("neorg.core.callbacks")

--     -- Map all the below keybinds only when the "norg" mode is active
--     keybinds.map_event_to_mode("norg", {
--         n = { -- Bind keys in normal mode
--             { "<C-s>", "core.integrations.telescope.find_linkable" },
--         },
--
--         i = { -- Bind in insert mode
--             { "<C-l>", "core.integrations.telescope.insert_link" },
--         },
--     }, {
--         silent = true,
--         noremap = true,
--     })
-- end)
