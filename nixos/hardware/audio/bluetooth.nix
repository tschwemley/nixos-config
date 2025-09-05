{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bluetuith
  ];

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-experimental;
    powerOnBoot = true;

  };

  services.blueman.enable = true;
}
