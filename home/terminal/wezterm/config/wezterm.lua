local config = {
	audible_bell = "Disabled",
	color_scheme = "stylix",
	default_prog = { "zsh" },
	enable_wayland = true,
	term = "wezterm",
}

require("fonts").apply_to_config(config)
require("keys").apply_to_config(config)

return config
