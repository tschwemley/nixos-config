{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-experimental;
    powerOnBoot = true;

    settings = {
      General.Experimental = true;
      Policy.AutoEnable = true;
    };
  };

  # Enables blueman service which provides blueman-applet and blueman-manager.
  services.blueman.enable = true;
}
