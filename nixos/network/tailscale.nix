{
  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    # checkReversePath = "loose"; # set to connect to exit nodes
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
}
