{ pkgs, ... }:
let
	xdgHomePath = ".config/awesome/rc.lua";
	configPath = ./../../home/config/awesome/rc.lua;
in
{
	xsession.enable = true;
	xsession.windowManager.awesome = {
		enable = true;
		luaModules = with pkgs.luaPackages; [
			luarocks
			luadbi-mysql
		];
	};
	home.file.${xdgHomePath}.source = configPath;
}
