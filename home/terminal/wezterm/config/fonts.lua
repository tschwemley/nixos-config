local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
	config.cell_width = 1.03
	config.font = wezterm.font("CaskaydiaCove Nerd Font")
	config.font_size = 14
	config.line_height = 1.05
end

return M
