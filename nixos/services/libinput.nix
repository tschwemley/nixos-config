{pkgs, ...}: {
  environment.systemPackages = [pkgs.libinput];
  services.xserver.enable = true;
  services.libinput.enable = true;
}
