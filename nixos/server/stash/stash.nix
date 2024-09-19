{
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
  environment = { };
  serviceConfig = {
    User = "thelounge";
    Group = "thelounge";
    Type = "simple";
    ExecStart = "/usr/bin/thelounge start";
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
}
