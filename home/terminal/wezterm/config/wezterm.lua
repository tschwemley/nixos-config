local wezterm = require("wezterm")

-- TODO: move to plugins.lua?

return {
   audible_bell = "Disabled",
   color_scheme = "GruvboxDarkMaterialHard",
   enable_wayland = true,
   font = wezterm.font("Hasklug Nerd Font Mono"),
   font_size = 17,
   keys = require("keys"),
   term = "wezterm",
}
