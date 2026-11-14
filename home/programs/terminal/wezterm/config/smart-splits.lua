--
-- REF:https://github.com/smart-splits-nvim/backend-wezterm#2-wezterm-plugin
--

local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/smart-splits-nvim/backend-wezterm")
local config = wezterm.config_builder()
-- the rest of your WezTerm config

smart_splits.apply_to_config(config, {
	-- the default config is shown here; omit the table entirely to use it as-is

	-- directional keys, in order of: left, down, up, right
	direction_keys = { "h", "j", "k", "l" },
	-- move/resize can also be configured separately, e.g.:
	--   direction_keys = {
	--     move = { 'h', 'j', 'k', 'l' },
	--     resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
	--   },

	modifiers = {
		move = "CTRL", -- e.g. CTRL+h to move left
		resize = "META", -- e.g. META+h to resize left
	},

	-- what happens when there's no WezTerm pane in that direction: both a *direct* keypress in a
	-- pane not running Neovim, and a request from Neovim reporting it hit its own edge, resolve
	-- through this same option — smart-splits.nvim's own `move.at_edge` config has no effect here:
	--   'stop'  -- pass the keystroke through to the program in the pane (default)
	--   'wrap'  -- activate the farthest pane in the opposite direction
	--   'split' -- split the current pane in that direction
	--   function(ctx) ... end -- decide yourself; see below
	at_edge = "stop",

	-- block navigation (both a direct keypress and a request from Neovim) while the current pane
	-- is zoomed in
	block_nav_on_zoom = false,

	log_level = "info", -- 'error' | 'warn' | 'info'
})

return config
