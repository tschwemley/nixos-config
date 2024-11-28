{
  config,
  pkgs,
  ...
}: let
  runDir = "/var/run/stash";
  dataDir = "/var/lib/stash";
in {
  systemd = {
    services.stash = {
      wantedBy = [
        "multi-user.target"
      ];
      after = [
        "network.target"
        "storage.mount"
      ];
      description = "Stash";
      path = with pkgs; [
        ffmpeg-full
        python3
        ruby
      ];
      environment = {
        # TODO: possibly enable this
        # STASH_CONFIG_FILE = "${cfg.dataDir}/config.yml";

        # LD_LIBRARY_PATH = "${dataDir}/python-modules";
        #
        # PYTHONPATH = "${dataDir}/python-modules";

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
        StateDirectory = dataDir;
        WorkingDirectory = dataDir;
        # WorkingDirectory = "/var/run/stash";

        # Hardening options
        DevicePolicy = "auto"; # needed for hardware acceleration
        PrivateDevices = false; # needed for hardware acceleration
        AmbientCapabilities = [""];
        CapabilityBoundingSet = [""];
        ProtectSystem = "full";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProcSubset = "pid";
        ProtectProc = "invisible";
        RemoveIPC = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_INET"
          "AF_INET6"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [
          "~@cpu-emulation"
          "~@debug"
          "~@mount"
          "~@obsolete"
          "~@privileged"
        ];
      };
    };

    tmpfiles.rules = [
      "d ${runDir} 0500 stash stash - -"
      "d ${dataDir} 0755 stash stash - -"
      "d ${dataDir}/python-modules 0755 stash stash - -"
    ];
  };

  users = {
    groups.stash = {};
    users.stash = {
      group = "stash";
      isSystemUser = true;
      home = dataDir;
    };
  };
}
