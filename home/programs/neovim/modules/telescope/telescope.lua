local builtin = require("telescope.builtin")
local telescope = require("telescope")
local trouble_telescope = require("trouble.sources.telescope")

-- Trouble telescope REF: https://github.com/folke/trouble.nvim?tab=readme-ov-file#telescope
--
-- NOTE: In future can use trouble_telescope.add to add more results w/o clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

telescope.setup({
   defaults = {
      mappings = {
         i = { ["<c-t>"] = trouble_telescope.open },
         n = { ["<c-t>"] = trouble_telescope.open },
      },
   },
   pickers = {
      find_files = {
         -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
         find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
   },
})

telescope.load_extension("frecency")
telescope.load_extension("manix")

-- [f]ind
vim.keymap.set("n", "<leader>f", builtin.find_files)

-- [s]earch commands
vim.keymap.set("n", "<leader>sc", builtin.commands)
vim.keymap.set("n", "<leader>sf", builtin.find_files)
vim.keymap.set("n", "<leader>sh", builtin.help_tags)
vim.keymap.set("n", "<leader>sk", builtin.keymaps)
vim.keymap.set("n", "<leader>sm", telescope.extensions.manix.manix)
vim.keymap.set("n", "<leader>st", builtin.live_grep)
vim.keymap.set("n", "<leader>sw", builtin.grep_string)

-- misc. commands
vim.keymap.set("n", "<leader>bl", builtin.buffers)
