{
  lib,
  pkgs,
  ...
}: {
  # environment.systemPackages = with pkgs; [netmaker netclient];

  # for message broker
  networking.firewall.allowedTCPPorts = [1883 8083 8883];
  networking.firewall.allowedTCPPortRanges = [
    # one wg port per client
    {
      from = 51820;
      to = 51826;
    }
  ];

  # [Unit]
  # Description=Netmaker Server
  # After=network.target
  #
  # [Service]
  # Type=simple
  # Restart=on-failure
  #
  # ExecStart=/usr/sbin/netmaker -c /etc/netmaker/netmaker.yml
  #
  # [Install]
  # WantedBy=multi-user.target
  #
  sops.secrets.netmaker-config = {
    sopsFile = ./secrets.yaml;
    path = "/var/lib/netmaker/netmaker.yaml";
  };

  systemd.services.netmaker = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      ExecStart = "${lib.getExe pkgs.netmaker} -c /var/lib/netmaker/netmaker.yaml";
      Restart = "on-failure";
      WorkingDirectory = "/var/lib/netmaker";
      StateDirectory = "netmaker";
    };

    description = "Netmaker";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
  };

  # services.netclient.enable = true;

  services.mosquitto = let
    address = "127.0.0.1";
    settings = {
      allow_anonymous = false;
      # protocol = "websocket";
    };
    users.root.hashedPasswordFile = ./mosquitto-pw;
  in {
    enable = true;
    # includeDirs = [./.];
    listeners = [
      {
        inherit address settings users;
        port = 1883;
      }
      {
        inherit address settings users;
        port = 8883;
      }
    ];
  };
}
