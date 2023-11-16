{
  pkgs,
  ipWithSubnet ? "10.1.1.1/24",
  port ? 51820,
  privateKeyFile ? "/persist/wireguard/private",
  ...
}: {
  networking.firewall = {
    allowedUDPPorts = [port];
  };

  networking.wireguard.interfaces = {
    inherit privateKeyFile;
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      ips = [ipWithSubnet];
      listenPort = port; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
    };
  };
}
