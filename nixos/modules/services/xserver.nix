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
