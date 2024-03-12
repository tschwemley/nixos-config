{config, ...}: let
  hostName = config.networking.hostName;
in {
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

      systemd.services.cockroachdb = {
        enable = true;
        description = "Cockroach Database cluster node";
        requires = [
          "network.target"
        ];
        wantedBy = [
          "default.target"
        ];
        environment = {};
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
          User = "cockroach";
        };
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [8080 26257];
      };

      users.users.cockroach.group = "cockroach";
    };
  };

  sops.secrets = {
    "ca.crt" = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/ca.crt";
    };
    "client.root.crt" = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/client.root.crt";
    };
    "client.root.key" = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/client.root.key";
    };
    "${hostName}.crt" = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/${hostName}.crt";
    };
    "${hostName}.key" = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
      path = "/run/secrets/cockroach_certs/${hostName}.key";
    };
  };
}
