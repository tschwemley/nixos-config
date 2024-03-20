let
  tailnetInterface = "tailscale0";
in {
  networking.firewall = {
    extraCommands = ''
      # Allow traffic on ports 9333-9337 from the tailnet interface
      iptables -A INPUT -i ${tailnetInterface} -p tcp --match multiport --dports 9333:9337,19333 -j ACCEPT
    '';
  };
}
