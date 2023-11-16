local wezterm = require 'wezterm'
local config = {
   audible_bell = 'Disabled',
   color_scheme = 'Gruvbox dark, medium (base16)',
   enable_wayland = false,
   font = wezterm.font('Hasklig'),
   font_size = 20,
   ssh_domains = wezterm.default_ssh_domains(),
   term = "xterm-256color",
}

for _, dom in ipairs(config.ssh_domains) do
   dom.assume_shell = 'Posix'
end

return config
