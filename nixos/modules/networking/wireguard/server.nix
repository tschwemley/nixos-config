{
  pkgs,
  ipWithSubnet ? "10.1.1.1/24",
  port ? 51820,
  privateKeyFile ? "/persist/wireguard/private",
  peers ? [],
  ...
}: 
let
	default = import ./. { inherit ipWithSubnet port privateKeyFile; };
in
{
  imports = [
	default
  ];

  # Enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = ["wg0"];

  networking.wireguard.interfaces = {
    wg0 = {
	  inherit peers;
      ips = [ipWithSubnet];
      listenPort = port;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';
    };
  };
}
