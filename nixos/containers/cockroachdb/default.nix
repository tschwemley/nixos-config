{config, ...}: let
  hostName = config.networking.hostName;
  users = {
    groups.cockroach = {
      name = "cockroach";
      gid = 200;
      members = [users.users.cockroach.name];
    };
    users.cockroach = {
      group = users.groups.cockroach.name;
      isSystemUser = true;
      name = "cockroach";
      uid = 201;
    };
  };
in {
  inherit users;

  containers.cockroachdb = {
    autoStart = true;

    bindMounts = {
      "/certs/ca.crt" = {
        hostPath = "/run/secrets/ca.crt";
      };
      "/certs/node.crt" = {
        hostPath = "/run/secrets/${hostName}.crt";
      };
      "/certs/node.key" = {
        hostPath = "/run/secrets/${hostName}.key";
      };
    };

    # network
    privateNetwork = true;
    hostAddress = "10.90.1.1";
    localAddress = "10.90.1.2";
    hostAddress6 = "fc00::90";
    localAddress6 = "fc00::91";
    forwardPorts = [{hostPort = 26257;}];

    config = {
      lib,
      pkgs,
      utils,
      ...
    }: {
      inherit users;

      imports = [../.];

      environment.systemPackages = with pkgs; [cockroachdb-bin];

      nixpkgs.config.allowUnfree = true;

      services.ntp = {
        enable = true;
        servers = [
          "time1.google.com"
          "time2.google.com"
          "time3.google.com"
          "time4.google.com"
        ];
      };

      systemd = {
        services.cockroach = {
          enable = true;
          description = "Cockroach Database cluster node";

          requires = ["network.target"];
          wantedBy = ["multi-user.target"];

          unitConfig.RequiresMountsFor = "/var/lib/cockroachdb /certs";

          serviceConfig = {
            Type = "notify";
            StateDirectory = "cockroach";
            StateDirectoryMode = "0700";
            WorkingDirectory = "/var/lib/cockroach";
            ExecStart = utils.escapeSystemdExecArgs [
              "${pkgs.cockroachdb-bin}/bin/cockroach"
              "start"
              "--certs-dir=/certs"
              "--advertise-addr=${hostName}.wyvern-map.ts.net"
              "--join=articuno.wyvern-map.ts.net,zapados.wyvern-map.ts.net,moltres.wyvern-map.ts.net"
              "--cache=.25"
              "--max-sql-memory=.25"
            ];
            TimeoutStopSec = 60;
            Restart = "always";
            RestartSec = 10;
            StandardOutput = "syslog";
            StandardError = "syslog";
            SyslogIdentifier = "cockroach";
            User = config.users.users.cockroach.name;
          };
        };
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [8080 26257];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [26257];

  sops.secrets = {
    "ca.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/run/secrets/cockroach_certs/ca.crt";
      owner = "cockroach";
    };
    "client.root.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/run/secrets/cockroach_certs/client.root.crt";
      owner = "cockroach";
    };
    "client.root.key" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/run/secrets/cockroach_certs/client.root.key";
      owner = "cockroach";
    };
    "${hostName}.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/run/secrets/cockroach_certs/${hostName}.crt";
      owner = "cockroach";
    };
    "${hostName}.key" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/run/secrets/cockroach_certs/${hostName}.key";
      owner = "cockroach";
    };
  };
}
