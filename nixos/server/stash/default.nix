{ config, pkgs, ... }:
let
  runDir = "/var/run/stash";
  stateDir = "/var/lib/stash";
in
{
  systemd = {
    tmpfiles.rules = [
      "d ${runDir} 0500 stash stash - -"
      "d ${stateDir} 0755 stash stash - -"
    ];

    services.stash = {
      after = [
        "network-online.target"
      ];
      description = "Stash";
      wantedBy = [
        "multi-user.target"
      ];
      wants = [
        "network-online.target"
      ];
      environment = {
        # STASH_HOST = "0.0.0.0";
        # STASH_HOST = "127.0.0.1";
        STASH_PORT = config.portMap.stash;
        # STASH_EXTERNAL_HOST = "stash.schwem.io";
      };
      path = [
        pkgs.ffmpeg_7-headless
      ];
      serviceConfig = {
        User = "stash";
        Group = "stash";
        Type = "simple";
        ExecStart = "${pkgs.stash}/bin/stash";
        ReadPaths = [ "/var/run/stash" ];
        Restart = "always";
        RestartSec = 5;
        StateDirectory = stateDir;
        WorkingDirectory = "/var/run/stash";

        # Hardening options
        LockPersonality = "yes";
        ProtectSystem = "yes";
        ProtectClock = "yes";
        ProtectControlGroups = "yes";
        ProtectHome = "yes";
        ProtectHostname = "yes";
        ProtectKernelLogs = "yes";
        ProtectKernelModules = "yes";
        ProtectKernelTunables = "yes";
        ProtectProc = "invisible";
        RemoveIPC = "yes";
        RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX AF_NETLINK";
        RestrictNamespaces = "yes";
        RestrictRealtime = "yes";
        NoNewPrivileges = "yes";
        PrivateDevices = "yes";
        PrivateTmp = "yes";
      };
    };
  };

  users = {
    groups.stash = { };
    users.stash = {
      group = "stash";
      isSystemUser = true;
      home = stateDir;
    };
  };
}
