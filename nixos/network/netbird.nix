{pkgs, ...}: {
  environment.systemPackages = [pkgs.netbird];
  services.netbird.enable = true;
  # services.netbird.tunnels = {};
}
