{config, pkgs, ...}: let
  stateDir = "netbird";
in {
  systemd.services.netbird-management = {
    description = "NetBird management server";
    documentation = "https://netbird.io/docs";
    after = "network-online.target syslog.target";
    wants = "network-online.target";
    serviceConfig = {
      ExecStart = "${pkgs.netbird}/bin/netbird-mgmt management run --config ${sops.templates.netbirdMgmtConfig.path}";
      Restart = "on-failure";
      CacheDirectory = stateDir;
      LogDirectory = stateDir;
      RuntimeDirectory = stateDir;
      StateDirectory = stateDir;
      StateDirectoryMode = "0700";
      WorkingDirectory = "/var/lib/${stateDir}";
    };
    wantedBy = "multi-user.target";
  };
}
    # Type = "simple"
    # EnvironmentFile = "-/etc/default/netbird-management"
    # ExecStart = "/usr/bin/netbird-mgmt management $FLAGS"
    # Restart = "on-failure"
    # RestartSec = 5
    # TimeoutStopSec = 10
    # CacheDirectory = "netbird"
    # ConfigurationDirectory = "netbird"
    # LogDirectory = "netbird"
    # RuntimeDirectory = "netbird"
    # StateDirectory = "netbird"
    #
    ## sandboxing
    # LockPersonality = "yes"
    # MemoryDenyWriteExecute = "yes"
    # NoNewPrivileges = "yes"
    # PrivateMounts = "yes"
    # PrivateTmp = "yes"
    # ProtectClock = "yes"
    # ProtectControlGroups = "yes"
    # ProtectHome = "yes"
    # ProtectHostname = "yes"
    # ProtectKernelLogs = "yes"
    # ProtectKernelModules = "yes"
    # ProtectKernelTunables = "yes"
    # ProtectSystem = "yes"
    # RemoveIPC = "yes"
    # RestrictNamespaces = "yes"
    # RestrictRealtime = "yes"
    # RestrictSUIDSGID = "yes"
