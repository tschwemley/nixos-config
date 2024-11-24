local dap, dapui = require("dap"), require("dapui")

-- setup language specific plugins
require("dap-go").setup()

-- load telescope extension
require("telescope").load_extension("dap")

--
dapui.setup()

local function openUI()
   dapui.open()
end

local function closeUI()
   dapui.close()
end

-- use nvim-dap events to open/close windows automatically
-- dap.listeners.before.attach.dapui_config = openUI
-- dap.listeners.before.launch.dapui_config = openUI
-- dap.listeners.before.event_terminated.dapui_config = closeUI
-- dap.listeners.before.event_exited.dapui_config = closeUI

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
vim.keymap.set("n", "<leader>do", dap.step_over)
vim.keymap.set("n", "<leader>du", dapui.toggle)
