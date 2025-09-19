local wezterm = require("wezterm")
local gui = wezterm.gui

local M = {}

function M.active_pane()
	return M:active_window():active_pane()
end

function M.active_window()
	for _, window in pairs(gui.gui_windows()) do
		if window:is_focused() then
			return window
		end
	end
	return nil
end

function M.table_merge(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

return M
