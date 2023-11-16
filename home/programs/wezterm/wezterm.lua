local wezterm = require 'wezterm'
local config = {
   audible_bell = 'Disabled',
   color_scheme = 'Gruvbox dark, medium (base16)',
   font = wezterm.font('Hasklig'),
   font_size = 20,
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
   ssh_domains = wezterm.default_ssh_domains(),
}

for _, dom in ipairs(config.ssh_domains) do
   dom.assume_shell = 'Posix'
end

return config
