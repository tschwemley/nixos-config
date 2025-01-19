{pkgs, ...}: {
  environment.systemPackages = [pkgs.d-spy];
  services.dbus.implementation = "broker";
}
