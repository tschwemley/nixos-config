-- local dap, dapui = require("dap"), require("dapui")
local dap = require("dap")

local launch =
	-- load telescope extension TODO: evaluate if still desired to load this
	require("telescope").load_extension("dap")

local dap_keymap = function(delete)
	local key = vim.keymap.set
	if delete then
		key = vim.keymap.del
	end

	key("n", "<c-j>", dap.step_into)
	key("n", "<c-k>", dap.step_out)
	key("n", "<c-l>", dap.step_over)
	key("n", "<c-b>", dap.toggle_breakpoint())
end

-- Dap attach handler
dap.listeners.before.attach.dapui_config = function()
	dap_keymap()
	dap.repl.open()
end

-- Dap launch handler
dap.listeners.before.launch.dapui_config = function()
	local repl = require("dap.repl")
	-- checking lenght of into is arbitrary - it could be any alias assigned below
	if #repl.commands.into == 1 then
		repl.commands = vim.tbl_extend("force", repl.commands, {
			-- Add a new alias for the existing .exit command
			exit = { "exit", ".exit", ".q" },
			into = { ".i", ".into" },
			out = { ".o", ".out" },
		})
	end

	dap.repl.open()
end

dap.listeners.after.disconnect.dapui_config = function()
	dap_keymap(true)
end

dap.listeners.after.terminate.dapui_config = function()
	dap_keymap(true)
end

dap.listeners.before.event_terminated.dapui_config = dap.repl.close
dap.listeners.before.event_exited.dapui_config = dap.repl.close

-- use nvim-dap events to open/close windows automatically
-- dap.listeners.before.attach.dapui_config = openUI
-- dap.listeners.before.launch.dapui_config = openUI
-- dap.listeners.before.event_terminated.dapui_config = closeUI
-- dap.listeners.before.event_exited.dapui_config = closeUI

-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
-- vim.keymap.set("n", "<leader>dc", dap.continue)
-- vim.keymap.set("n", "<leader>di", dap.step_into)
-- vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
-- vim.keymap.set("n", "<leader>do", dap.step_over)
-- vim.keymap.set("n", "<leader>du", dapui.toggle)
