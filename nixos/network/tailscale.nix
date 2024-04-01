{
  networking.firewall.trustedInterfaces = ["tailscale0"];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
  };
}
