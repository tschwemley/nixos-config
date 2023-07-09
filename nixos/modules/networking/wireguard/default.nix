{
  pkgs,
  ipWithSubnet,
  port,
  privateKeyFile,
  ...
}: {
  networking.firewall = {
    allowedUDPPorts = [port];
  };

  networking.wireguard.interfaces = {
    wg0 = {
	  inherit privateKeyFile;
      ips = [ipWithSubnet];
      listenPort = port; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
    };
  };
}
