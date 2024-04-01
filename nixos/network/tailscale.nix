{upFlags ? [], ...}: let
  extraUpFlags = ["--ssh"] + upFlags;
in {
  networking.firewall.trustedInterfaces = ["tailscale0"];

  services.tailscale = {
    inherit extraUpFlags;
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
  };
}
