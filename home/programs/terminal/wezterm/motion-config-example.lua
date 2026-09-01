-- Pull in the wezterm API
local os = require("os")
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

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

config.keys = {
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
}
