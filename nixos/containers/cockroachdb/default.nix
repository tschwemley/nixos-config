{config, ...}: let
  hostName = config.networking.hostName;
  # we want the user to be shared between the host and contianer with the same uid/gid to ensure
  # proper perms on bind mounts
  users = {
    groups.cockroach = {
      gid = 1100;
    };
    users.cockroach = {
      group = "cockroach";
      isNormalUser = true;
      uid = 1100;
    };
  };
in {
  inherit users;

  # imports = [
  #   ./settings.nix
  #   ./virtualhost.nix
  # ];

  containers.cockroachdb = {
    autoStart = true;

    bindMounts = {
      "/var/lib/cockroach/certs/ca.crt" = {
        hostPath = "/run/secrets/ca.crt";
      };
      "/var/lib/cockroach/certs/${hostName}.crt" = {
        hostPath = "/run/secrets/${hostName}.crt";
      };
      "/var/lib/cockroach/certs/${hostName}.key" = {
        hostPath = "/run/secrets/${hostName}.key";
      };
    };

    # network
    privateNetwork = true;
    hostAddress = "10.90.1.1";
    localAddress = "10.90.1.2";
    hostAddress6 = "fc00::90";
    localAddress6 = "fc00::91";

    config = {
      lib,
      pkgs,
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
        services.cockroachdb = {
          enable = true;
          description = "Cockroach Database cluster node";
          requires = [
            "network.target"
          ];
          wantedBy = [
            "default.target"
          ];
          serviceConfig = {
            Type = "notify";
            StateDirectory = "/var/lib/cockroach";
            WorkingDirectory = "/var/lib/cockroach";
            ExecStart = lib.concatStringsSep " " [
              "${pkgs.cockroachdb-bin}/bin/cockroach"
              "start"
              "--certs-dir=certs"
              "--advertise-addr=${hostName}.wyvern-map.ts.net"
              "--join=articuno.wyvern-map.ts.net,zapados.wyvern-map.ts.net,moltres.wyvern-map.ts.net"
              "--cache=.25"
              "--max-sql-memory=.25"
            ];
            TimeoutStopSec = "300";
            Restart = "always";
            RestartSec = "10";
            StandardOutput = "syslog";
            StandardError = "syslog";
            SyslogIdentifier = "cockroach";
            User = config.users.users.cockroach.name;
          };
        };

        tmpfiles.rules = [
          "d /var/lib/cockroach 1755 cockroach cockroach"
          "d /var/lib/cockroach/certs 1755 cockroach cockroach"
        ];
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [8080 26257];
      };
    };
  };

  sops.secrets = {
    "ca.crt" = {
      sopsFile = ./secrets.yaml;
      group = config.users.users.cockroach.group;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/ca.crt";
      owner = config.users.users.cockroach.name;
    };
    "client.root.crt" = {
      sopsFile = ./secrets.yaml;
      group = config.users.users.cockroach.group;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/client.root.crt";
      owner = config.users.users.cockroach.name;
    };
    "client.root.key" = {
      sopsFile = ./secrets.yaml;
      group = config.users.users.cockroach.group;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/client.root.key";
      owner = config.users.users.cockroach.name;
    };
    "${hostName}.crt" = {
      sopsFile = ./secrets.yaml;
      group = config.users.users.cockroach.group;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/${hostName}.crt";
      owner = config.users.users.cockroach.name;
    };
    "${hostName}.key" = {
      sopsFile = ./secrets.yaml;
      group = config.users.users.cockroach.group;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/${hostName}.key";
      owner = config.users.users.cockroach.name;
    };
  };
}
