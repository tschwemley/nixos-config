local wezterm = require("wezterm")

local action = require("wezterm").action
local pane_utils = require("pane_utils")

return {
	{
		key = "D",
		mods = "CTRL|SHIFT",
		action = action.ShowDebugOverlay,
		description = "Open Wezterm debug overlay",
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = action.SendKey({ key = "l", mods = "CTRL" }),
		description = "Clear screen",
	},
	--
	-- pane management
	{
		key = "%",
		mods = "CTRL|SHIFT",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(pane_utils.cycle_layouts({})),
		description = "Cycle layouts",
	},
}
