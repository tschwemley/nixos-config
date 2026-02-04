local wezterm = require("wezterm")
local action = wezterm.action

-- local handle_movement_key = function(key)
-- 	if key == "j" then
-- 		print("key:", key)
-- 		return action.ActivatePaneDirection("Down")
-- 	end
--
-- 	return nil
-- end

local move_around = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/.local/bin/wezterm.nvim.navigator"
			.. " "
			.. direction_nvim
	)
	if result then
		window:perform_action(action({ SendString = "\x17" .. direction_nvim }), pane)
	else
		window:perform_action(action({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

local vim_resize = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/.local/bin/wezterm.nvim.navigator"
			.. " "
			.. direction_nvim
	)
	if result then
		window:perform_action(action({ SendString = "\x1b" .. direction_nvim }), pane)
	else
		window:perform_action(action({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("resize-left", function(window, pane)
	vim_resize(window, pane, "Left", "h")
end)

wezterm.on("resize-right", function(window, pane)
	vim_resize(window, pane, "Right", "l")
end)

wezterm.on("resize-up", function(window, pane)
	vim_resize(window, pane, "Up", "k")
end)

wezterm.on("resize-down", function(window, pane)
	vim_resize(window, pane, "Down", "j")
end)

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

	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },

	-- pane management
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
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
		action = wezterm.action_callback(function(window, pane)
			-- When using pane:split(), 'size' works to set the dimension of the new pane.
			-- The direction relates to the new pane's position relative to the current one.
			-- 'CurrentPaneDomain' is the default for pane:split(), so it's often not needed.
			return pane:split({
				direction = "Bottom",
				size = 22,
			})
		end),
	},
	-- CTRL + (h,j,k,l) to move between panes
	{
		key = "h",
		mods = "CTRL",
		action = action({ EmitEvent = "move-left" }),
	},
	{
		key = "j",
		mods = "CTRL",
		action = action({ EmitEvent = "move-down" }),
	},
	{
		key = "k",
		mods = "CTRL",
		action = action({ EmitEvent = "move-up" }),
	},
	{
		key = "l",
		mods = "CTRL",
		action = action({ EmitEvent = "move-right" }),
	},
	-- ALT + (h,j,k,l) to resize panes
	{
		key = "h",
		mods = "ALT",
		action = action({ EmitEvent = "resize-left" }),
	},
	{
		key = "j",
		mods = "ALT",
		action = action({ EmitEvent = "resize-down" }),
	},
	{
		key = "k",
		mods = "ALT",
		action = action({ EmitEvent = "resize-up" }),
	},
	{
		key = "l",
		mods = "ALT",
		action = action({ EmitEvent = "resize-right" }),
	},

	-- {
	-- 	key = "h",
	-- 	mods = "CTRL",
	-- 	action = action.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "CTRL",
	-- 	action = action.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL",
	-- 	action = action.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "CTRL",
	-- 	action = handle_movement_key("j"),
	-- },
	-- {
	--    key = "l",
	--    mods = "CTRL|SHIFT",
	--    action = wezterm.action_callback(pane_utils.cycle_layouts({})),
	--    description = "Cycle layouts",
	-- },
}
