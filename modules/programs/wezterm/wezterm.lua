return {
  audible_bell = "Disabled",
  color_scheme = "Gruvbox dark, medium (base16)",
  font = wezterm.font("Hasklig"),
  font_size = 15,
  keys = {
	{
	  key = 'h',
	  mods = 'CTRL|ALT',
	  action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
	  key = 'v',
	  mods = 'CTRL|ALT',
	  action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},
  },
  enable_wayland = false,
  unix_domains = {
  },
}
