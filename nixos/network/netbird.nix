{pkgs, ...}: {
  environment.systemPackages = [pkgs.netbird-ui];
  services.netbird.enable = true;
  # services.netbird.tunnels = {};
}
