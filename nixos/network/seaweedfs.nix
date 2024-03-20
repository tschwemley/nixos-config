let
  tailnetInterface = "tailscale0";
in {
  networking.firewall = {
    allowedTCPPorts = [9333 9334 9335 9336 9337 19333];

    extraCommands = ''
      # Allow traffic on ports 9333-9337 from the tailnet interface
      ip46tables -A INPUT -i ${tailnetInterface} -p tcp --match multiport --dports 9333:9337,19333 -j ACCEPT
    '';

    extraStopCommands = ''
      # Allow traffic on ports 9333-9337 from the tailnet interface
      iptables -A INPUT -i ${tailnetInterface} -p tcp --match multiport --dports 9333:9337,19333 -j ACCEPT || true
    '';
  };
}
