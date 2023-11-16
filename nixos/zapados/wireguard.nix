{pkgs, ...}: {
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = ["wg0"];
  networking.firewall.allowedUDPPorts = [51820];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.1.1.1/24"];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.1.1.1/24 -o eth0 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.1.1.1/24 -o eth0 -j MASQUERADE
      '';

      privateKeyFile = "/persist/wireguard/private";

      peers = [
        {
          #moltres
          publicKey = "SHsUHFVnJEez4bZQHPRKXBqmijOb7W7mf8x75KXqQh8=";
          allowedIPs = ["10.1.1.2/32"];
        }
      ];
    };
  };
}
