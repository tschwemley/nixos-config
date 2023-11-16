local wezterm = require "wezterm"
return {
   audible_bell = "Disabled",
   color_scheme = "Gruvbox dark, medium (base16)",
   font = wezterm.font("Hasklig"),
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
   ssh_domain = {
      {
         name = "dev",
         remote_address = 'dev',
         username = 'tschwemley',
      },
   },
}
