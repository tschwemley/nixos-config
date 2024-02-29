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

  systemd.network.wait-online.enable = false;
}
