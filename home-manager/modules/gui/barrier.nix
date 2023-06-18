{pkgs, ...}: {
  home.packages = with pkgs; [pkgs.barrier];

  # barrier communicates on 24800 by default
  networking.firewall.allowedTCPPorts = [24800];
}
