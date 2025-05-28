local wezterm = require("wezterm")
local font_config = require("fonts")

-- Helper function to merge (shallow) t2 into t1
-- Keys in t2 will overwrite keys in t1 if they conflict.
local function table_merge(t1, t2)
   for k, v in pairs(t2) do
      t1[k] = v
   end
   return t1
end

local config = {
   audible_bell = "Disabled",
   color_scheme = "GruvboxDarkMaterialHard",
   default_prog = { "zsh" },
   enable_wayland = true,
   keys = require("keys"),
   term = "wezterm",
}

return table_merge(config, font_config)
