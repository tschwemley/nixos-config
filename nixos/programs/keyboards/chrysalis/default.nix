{pkgs, ...}: {
  environment.systemPackages = [pkgs.chrysalis];

  # add req. udev rules so non-root can make changes
  services.udev.packages = [pkgs.chrysalis];
}
