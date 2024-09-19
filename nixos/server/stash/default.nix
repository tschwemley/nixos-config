{ config, pkgs, ... }:
let
  stateDir = "/var/lib/stash";
in
{
  # expects ffmpeg to be available
  environment.systemPackages = [
    pkgs.ffmpeg_7-headless
  ];

  systemd = {
    tmpfiles.rules = [
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
      serviceConfig = {
        User = "stash";
        Group = "stash";
        Type = "simple";
        ExecStart = "${pkgs.stash}/bin/stash";
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
