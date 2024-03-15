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
      ["core.export"] = {},
      -- TODO: re-enable when back on nvim >= 0.10.0
      -- ["core.ui.calendar"] = {},
   }
}

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
   local venn_enabled = vim.inspect(vim.b.venn_enabled)
   if venn_enabled == "nil" then
      vim.b.venn_enabled = true
      vim.cmd [[setlocal ve=all]]
      -- draw a line on HJKL keystokes
      vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
      -- draw a box by pressing "f" with visual selection
      vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
      print("Enabled Venn")
   else
      vim.cmd [[setlocal ve=]]
      vim.cmd [[mapclear <buffer>]]
      vim.b.venn_enabled = nil
      print("Disabled Venn")
   end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true })


-- vim.api.nvim_create_user_command('Journal', 'Neorg journal', {})
--
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
