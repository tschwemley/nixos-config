{
  services.openssh = {
    enable = true;
    settings = {
      GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };

  systemd.networkd.enable = true;
}
