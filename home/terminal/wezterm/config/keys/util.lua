local action = require("wezterm").action

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
}
