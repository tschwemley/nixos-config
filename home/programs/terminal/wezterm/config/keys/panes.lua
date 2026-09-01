local wezterm = require("wezterm")

return {
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			local direction = "Down"
			local size = { Cells = 20 }
			print("num panes:", #pane:tab():panes())
			if #pane:tab():panes() > 1 then
				direction = "Right"
				size = nil
			end

			return pane:split({
				direction = direction,
				size = size,
				command = { args = { "zsh" } },
			})
		end),
	},
	{
		key = "%",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		-- action = action.SplitVertical({ domain = "CurrentPaneDomain", size = { Percent = 15 }, }),
		action = wezterm.action_callback(function(_, pane)
			-- When using pane:split(), 'size' works to set the dimension of the new pane.
			-- The direction relates to the new pane's position relative to the current one.
			-- 'CurrentPaneDomain' is the default for pane:split(), so it's often not needed.
			return pane:split({
				direction = "Bottom",
				size = 17,
			})
		end),
	},
}
