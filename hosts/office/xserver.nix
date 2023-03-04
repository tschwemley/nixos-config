{ pkgs, ... }:
{
# Configure keymap in X11
	services.xserver = {
		enable = true;
		layout = "us";
		# xkbVariant = "";
		
		displayManager = {
			sddm.enable = true;
			defaultSession = "none+awesome";
		};

		# TODO: I think I would prefer this to be managed at the user level; but check if it proves
		# to be troublesome with system config on NixOS
		windowManager.awesome = {
			enable = true;
			luaModules = with pkgs.luaPackages; [
				luarocks
				luadbi-mysql
				vicious
			];
		};
	};
}
