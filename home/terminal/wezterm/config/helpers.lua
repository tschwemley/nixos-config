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

return M
