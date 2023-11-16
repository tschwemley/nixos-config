{ lib, ... }: {
	programs.wezterm = {
		enable = true;
		extraConfig = lib.fileContents ./wezterm.lua;
	};
}
