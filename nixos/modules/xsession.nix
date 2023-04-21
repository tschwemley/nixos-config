{ pkgs, lib, ... }:

{
  services.xserver = {
  	enable = true;

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

  #hardware.video.hidpi.enable = lib.mkDefault true;
  services.xserver.dpi = 192;
}
