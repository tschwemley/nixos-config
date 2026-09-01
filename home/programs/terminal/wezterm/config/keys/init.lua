-- package.path = package.path .. "./?.lua"

local function merge_keybinds(to_merge, dest)
	for _, keybind in ipairs(to_merge) do
		table.insert(dest, keybind)
	end
end

local M = {}

function M.apply_to_config(config)
	config.keys = {}

	merge_keybinds(require("keys.panes"), config.keys)
	merge_keybinds(require("keys.split_nav"), config.keys)
	merge_keybinds(require("keys.util"), config.keys)
end

return M
