{
  config,
  pkgs,
  utils,
  ...
}: let
  hostName = config.networking.hostName;
in {
  imports = [./virtualhost.nix];

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

      serviceConfig = {
        Type = "notify";
        # Fixes an error where cockroachdb attempts to notify from a thread outside main process:
        #   Got notification message from PID XXXX, but reception only permitted for main PID YYYY
        NotifyAccess = "all";

        WorkingDirectory = "/var/lib/cockroach";
        StateDirectory = "cockroach";
        StateDirectoryMode = "0700";

        StandardOutput = "syslog";
        StandardError = "syslog";
        SyslogIdentifier = "cockroach";

        Restart = "always";
        RestartSec = 10;
        TimeoutStopSec = 60;

        User = config.users.users.cockroach.name;

        ExecStart = utils.escapeSystemdExecArgs [
          "${pkgs.cockroachdb-bin}/bin/cockroach"
          "start"
          "--accept-sql-without-tls"
          "--cache=.25"
          "--certs-dir=certs"
          "--http-addr=${hostName}.wyvern-map.ts.net:26080"
          "--http-port=26080"
          "--join=articuno.wyvern-map.ts.net:26257,zapados.wyvern-map.ts.net:26257,moltres.wyvern-map.ts.net:26257"
          "--listen-addr=${hostName}.wyvern-map.ts.net:26257"
          "--max-sql-memory=.25"
          # "--sql-addr=${hostName}.wyvern-map.ts.net:26258"
          "--port=26257"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [5432 26257 26080];

  sops.secrets = {
    "ca.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/ca.crt";
      owner = "cockroach";
    };
    "client.root.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/client.root.crt";
      owner = "cockroach";
    };
    "client.root.key" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/client.root.key";
      owner = "cockroach";
    };
    "${hostName}.crt" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/node.crt";
      owner = "cockroach";
    };
    "${hostName}.key" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/node.key";
      owner = "cockroach";
    };
  };

  users = {
    groups.cockroach = {
      name = "cockroach";
      gid = 200;
      members = [config.users.users.cockroach.name];
    };
    users.cockroach = {
      group = config.users.groups.cockroach.name;
      isSystemUser = true;
      name = "cockroach";
      uid = 201;
    };
  };
}
