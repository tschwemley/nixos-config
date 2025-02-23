local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	audible_bell = "Disabled",
	-- color_scheme = "Gruvbox Material (Gogh)",
	color_scheme = "gruvbox_material_dark_medium",
	color_schemes = {
		["gruvbox_material_dark_hard"] = {
			foreground = "#D4BE98",
			background = "#1D2021",
			cursor_bg = "#D4BE98",
			cursor_border = "#D4BE98",
			cursor_fg = "#1D2021",
			selection_bg = "#D4BE98",
			selection_fg = "#3C3836",

			ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
		["gruvbox_material_dark_medium"] = {
			foreground = "#D4BE98",
			background = "#282828",
			cursor_bg = "#D4BE98",
			cursor_border = "#D4BE98",
			cursor_fg = "#282828",
			selection_bg = "#D4BE98",
			selection_fg = "#45403d",

			ansi = { "#282828", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
		enable_wayland = false,
	},
	font = wezterm.font("Hasklug Nerd Font Mono"),
	font_size = 18,
	keys = {
		{
			key = "%",
			mods = "CTRL|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = '"',
			mods = "CTRL|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "CTRL",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CTRL",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CTRL",
			action = act.ActivatePaneDirection("Down"),
		},
		{ -- clear screen on ctrl+alt+l
			key = "l",
			mods = "CTRL|ALT",
			action = act.SendKey({
				key = "l",
				mods = "CTRL",
			}),
		},
	},
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
				end
			end),
		},
	},
	ssh_domains = wezterm.default_ssh_domains(),
	term = "wezterm",
}

for _, dom in ipairs(config.ssh_domains) do
	dom.assume_shell = "Posix"
end

return config
