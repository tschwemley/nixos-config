{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;

    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
    };

	# this could also bet setup via home-manager but I found it more straightforward here.
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };

  services.xserver.dpi = 192;
}
