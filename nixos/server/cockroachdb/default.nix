{
  config,
  pkgs,
  utils,
  ...
}: let
  hostName = config.networking.hostName;
in {
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
        StateDirectory = "cockroach";
        StateDirectoryMode = "0700";
        WorkingDirectory = "/var/lib/cockroach";
        ExecStart = utils.escapeSystemdExecArgs [
          "${pkgs.cockroachdb-bin}/bin/cockroach"
          "start"
          "--advertise-addr=${hostName}.wyvern-map.ts.net"
          "--http-addr=:26258"
          "--join=articuno.wyvern-map.ts.net,zapados.wyvern-map.ts.net,moltres.wyvern-map.ts.net"
          "--certs-dir=certs"
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

  networking.firewall.allowedTCPPorts = [26257 26258];

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
      path = "/var/lib/cockroach/certs/${hostName}.crt";
      owner = "cockroach";
    };
    "${hostName}.key" = {
      sopsFile = ./secrets.yaml;
      group = "cockroach";
      mode = "0400";
      path = "/var/lib/cockroach/certs/${hostName}.key";
      owner = "cockroach";
    };
  };

  users = {
    groups.cockroach = {
      name = "cockroach";
      gid = 200;
      members = [config.users.users.cockroach.name];
    };
    config.users.cockroach = {
      group = config.users.groups.cockroach.name;
      isSystemUser = true;
      name = "cockroach";
      uid = 201;
    };
  };
}
