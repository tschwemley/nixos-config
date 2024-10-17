{ config, pkgs, ... }:
{
  services.postgresql.ensureDatabases = [ "bitmagnet" ];
  services.postgresql.ensureUsers = [
    {
      name = "bitmagnet";
      ensureClauses = {

      };
    }
  ];

  systemd.services.bitmagnet = {
    after = [
      "network.target"
    ];
    description = "Bitmagnet indexer and crawler";
    wantedBy = [
      "multi-user.target"
    ];
    environment = { };
    serviceConfig = {
      User = config.users.users.bitmagnet.name;
      Group = config.users.groups.bitmagnet.name;
      ExecStart = "${pkgs.bitmagnet}/bin/bitmagnet worker run --all";
      Restart = "on-failure";
      RestartSec = "15s";
      UMask = "0077";
      CapabilityBoundingSet = "";
      LockPersonality = "true";
      MemoryDenyWriteExecute = "true";
      NoNewPrivileges = "true";
      PrivateDevices = "true";
      PrivateMounts = "true";
      PrivateTmp = "true";
      PrivateUsers = "true";
      ProcSubset = "pid";
      ProtectClock = "true";
      ProtectControlGroups = "true";
      ProtectHome = "true";
      ProtectHostname = "true";
      ProtectKernelLogs = "true";
      ProtectKernelModules = "true";
      ProtectKernelTunables = "true";
      ProtectProc = "invisible";
      ProtectSystem = "strict";
      RemoveIPC = "true";
      RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6";
      RestrictNamespaces = "true";
      RestrictRealtime = "true";
      RestrictSUIDSGID = "true";
      SystemCallArchitectures = "native";
      SystemCallFilter = "@system-service ~@privileged";
    };
  };

  users = {
    groups.bitmagnet = { };

    users.bitmagnet = {
      isSystemUser = true;
      group = config.users.groups.bitmagnet.name;
    };
  };
}
