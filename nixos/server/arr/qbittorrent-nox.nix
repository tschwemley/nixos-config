{
  config,
  pkgs,
  utils,
  ...
}: let
  downloadsDir = "/storage/downloads/torrent";
  stateDir = "qbittorrent-nox";

  startupCommand = utils.escapeSystemdExecArgs [
    # Basic startup
    "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox"
    "--confirm-legal-notice"
    "--webui-port=${config.portMap.qtbittorrentWeb}"
    "--torrenting-port=${config.portMap.qtbittorrentTorrent}"
    "--profile=/var/lib/qbittorrent-nox"
  ];
in {
  systemd = {
    services.qbittorrent = {
      description = "qbittorrent-nox";
      after = [
        "network.target"
        "storage.mount"
        "tailscaled.service"
      ];
      wants = [
        "network.target"
        "storage.mount"
        "tailscaled.service"
      ];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = "qbittorrent-nox";
        Group = "qbittorrent-nox";
        ExecStart = startupCommand;
        Restart = "always";
        StateDirectory = stateDir;

        # Hardening
        NoNewPrivileges = true;
        PrivateTmp = true;
        PrivateDevices = true;
        DevicePolicy = "closed";
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        LockPersonality = true;

        ReadPaths = [
          downloadsDir
        ];
      };
    };

    tmpfiles.rules = [
      "d '${downloadsDir}' 0760 qbittorrent-nox arr - -"
      #   "d '${stateDir}' 0700 qbittorrent-nox arr - -"
    ];
  };

  users.users.qbittorrent-nox = {
    group = "qbittorrent-nox";
    isSystemUser = true;
    extraGroups = ["arr"];
  };

  users.groups.qbittorrent-nox = {};
}
