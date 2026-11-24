local config = require("wezterm").config_builder()

config.audible_bell = "Disabled"
config.color_scheme = "stylix"
config.default_prog = { "zsh" }
config.enable_wayland = true
config.term = "wezterm"

require("fonts").apply_to_config(config)
require("keys").apply_to_config(config)
require("mouse").apply_to_config(config)
-- require("smart-splits").apply_to_config(config)

return config
