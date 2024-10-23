{
  config,
  pkgs,
  utils,
  ...
}:
let
  downloadsDir = "/storage/downloads/torrent";
  stateDir = "/var/lib/qbittorrent";

  startupCommand = utils.escapeSystemdExecArgs [
    # Basic startup
    "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox"
    "--confirm-legal-notice"
    "--webui-port=${config.portMap.qtbittorentWeb}"
    "--torrenting-port=${config.portMap.qbittorentTorrent}"
    "-d"
  ];
in
{
  systemd = {

    services.qbittorrent = {
      description = "qbittorrent";
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
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = "qbittorrent";
        Group = "qbittorrent";
        ExecStart = startupCommand;
        Restart = "always";
        StateDirectory = stateDir;

        # Hardening
        NoNewPrivileges = true;
        PrivateTmp = true;
        PrivateDevices = true;
        DevicePolicy = "closed";
        ProtectSystem = "strict";
        ReadWritePaths = [
          downloadsDir
          stateDir
        ];
        ProtectHome = "read-only";
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        LockPersonality = true;
      };
    };

    tmpfiles.rules = [
      "d '${downloadsDir}' 0760 qbittorrent arr - -"
      "d '${stateDir}' 0700 qbittorrent arr - -"
    ];
  };

  users.users.qbittorrent = {
    group = "qbittorrent";
    isSystemUser = true;
    extraGroups = [ "arr" ];
  };

  users.groups.qbittorrent = { };
}
