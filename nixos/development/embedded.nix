{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    esptool
    platformio
    platformio-core
  ];

  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];
}
