{ lib, ... }:
{
	flake = {
		nixosModules = {
			desktop = {
				gaming = {};
				guiApps = {};	
				windowManager = {};
			};
		};
	};

  # services.xserver = {
  #   enable = true;
  #   displayManager.lightdm.enable = true;
  # };
}
