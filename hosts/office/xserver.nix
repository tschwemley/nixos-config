{ pkgs, ... }:
{
# Configure keymap in X11
	services.xserver = {
		enable = true;
		layout = "us";
		xkbVariant = "";
		
		displayManager = {
			sddm.enable = true;
			defaultSession = "none+awesome";
		};

		windowManager.awesome = {
			enable = true;
			luaModules = with pkgs.luaPackages; [
				luarocks
				luadbi-mysql
			];
		};
	};
}
