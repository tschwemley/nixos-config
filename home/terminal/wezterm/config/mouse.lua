local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
	local scroll_distance = 1
	config.mouse_bindings = {
		-- Slower scroll up/down (3 lines instead of Page Up/Down)
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "NONE",
			action = wezterm.action.ScrollByLine(-scroll_distance),
			alt_screen = false,
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "NONE",
			action = wezterm.action.ScrollByLine(scroll_distance),
			alt_screen = false,
		},
	}
end

return M
