{
  services.openssh = {
    enable = true;
    settings = {
      GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };

  systemd.network.enable = true;
}
