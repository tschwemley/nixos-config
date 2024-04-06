{
  # networking.nftables.enable = true;

  # always use systemd-resolved
  services.resolved.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      #GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };
}
