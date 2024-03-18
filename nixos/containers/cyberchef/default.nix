{
  containers.cyberchef = {
    autoStart = true;

    # network
    privateNetwork = true;
    hostAddress = "10.10.4.1";
    localAddress = "10.10.4.2";
    hostAddress6 = "fc00::41";
    localAddress6 = "fc00::42";

    config = {pkgs, ...}: {
      imports = [
        ./.
      ];

      networking.firewall.allowedTCPPorts = [80];

      systemd.services.cyberchef = {
        enable = true;
        serviceConfig = {
          Type = "simple";
          User = "cyberchef";
          Group = "cyberchef";

          ExecStart = "${pkgs.cyberchef}/bin/cyberchef";
          WorkingDirectory = "/var/lib/cyberchef";
          StateDirectory = "cyberchef";
          SyslogIdentifier = "cyberchef";
        };

        description = "Cyberchef";
        after = ["network.target"];
        wantedBy = ["multi-user.target"];
      };

      users = {
        groups.cyberchef = {};
        users.cyberchef = {
          group = "cyberchef";
          isSystemUser = true;
        };
      };
    };
  };
}
