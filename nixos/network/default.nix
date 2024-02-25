{
  networking.useNetworkd = true;
  services.openssh = {
    enable = true;
    settings = {
      #GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };
  # TODO: fix this
  systemd.network.wait-online.enable = false;
}
