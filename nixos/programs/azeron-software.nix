{ pkgs, ... }: {
  boot.kernelModules = [ "xpad" ];

  environment.systemPackages = with pkgs; [
    azeron-software
    dfu-util
    usbutils
  ];

  services.udev.packages = with pkgs; [
    azeron-software
    teensy-udev-rules
  ];
}
