{pkgs, ...}: {
  environment.systemPackages = with pkgs; [netmaker netclient];

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
  # systemd.services.netmaker = {
  # };

  # services.netclient.enable = true;

  services.mosquitto = {
    enable = true;
    includeDirs = [./.];
  };
}
