local wezterm = require 'wezterm'

return {
    -- This will create a new split and run your default program inside it
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
}

