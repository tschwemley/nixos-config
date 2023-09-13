{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;

    displayManager = {
      sddm.enable = true;
      defaultSession = "hyprland";
    };

    # dpi = 192;

    libinput.enable = true;

    # this could also be setup via home-manager but I found it more straightforward here.
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    xclip
    xdotool
  ];
}
