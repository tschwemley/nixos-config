local wezterm = require("wezterm")

return {
	audible_bell = "Disabled",
	color_scheme = "GruvboxDarkMaterialHard",
	default_prog = { "zsh" },
	enable_wayland = true,
	font = wezterm.font("Hasklug Nerd Font Mono"),
	font_size = 17,
	keys = require("keys"),
	term = "wezterm",
}
