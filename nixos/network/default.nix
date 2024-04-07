{
  networking.nftables.enable = true;

  # always use systemd-resolved
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    domains = ["~."];
    fallbackDns = ["194.242.2.2"];
  };

  services.openssh = {
    enable = true;
    settings = {
      #GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };
}
