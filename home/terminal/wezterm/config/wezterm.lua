local font_config = require("fonts")

local config = {
	audible_bell = "Disabled",
	color_scheme = "GruvboxMaterialDarkHard",
	default_prog = { "zsh" },
	enable_wayland = true,
	keys = require("keys"),
	ssh_domains = require("ssh_domains"),
	term = "wezterm",
}

-- Helper function to merge (shallow) t2 into t1.
-- Keys in t2 will overwrite keys in t1 if they conflict.
--
-- NOTE: defining here instead of helpers prevents error span during nixos-rebuild
local table_merge = function(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

return table_merge(config, font_config)
