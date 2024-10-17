{
  config,
  pkgs,
  utils,
  ...
}:
let
  stateDir = "/var/lib/bitmagnet";
in
{
  # services.postgresql.ensureDatabases = [ "bitmagnet" ];
  # services.postgresql.ensureUsers = [
  #   {
  #     name = "bitmagnet";
  #     ensureClauses = {
  #       ensureDBOwnership = true;
  #     };
  #   }
  # ];

  systemd.services.bitmagnet = {
    after = [
      "network.target"
      "postgresql.service"
    ];
    description = "Bitmagnet indexer and crawler";
    wantedBy = [
      "multi-user.target"
    ];
    wants = [ "postgresql.service" ];
    serviceConfig = {
      User = config.users.users.bitmagnet.name;
      Group = config.users.groups.bitmagnet.name;
      EnvironmentFile = config.sops.secrets.bitmagnet_env.path;
      ExecStart = "${pkgs.bitmagnet}/bin/bitmagnet worker run --all";
      Restart = "on-failure";
      RestartSec = "15s";
      StateDirectory = stateDir;

      # hardening options
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

  sops.secrets.bitmagnet_env = {
    group = "bitmagnet";
    owner = "bitmagnet";
    path = "${stateDir}/.env";
    sopsFile = ../../../secrets/server/bitmagnet.env;
  };

  users = {
    groups.bitmagnet = { };

    users.bitmagnet = {
      isSystemUser = true;
      group = config.users.groups.bitmagnet.name;
    };
  };
}
