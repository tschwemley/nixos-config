{pkgs, ...}: let
  listenAddress = "127.0.0.1";
  port = "8180";
in {
  after = [
    "network.service"
  ];
  description = "redlib daemon";
  wantedBy = [
    "default.target"
  ];
  environment = {};
  serviceConfig = {
    DynamicUser = "yes";
    EnvironmentFile = "-/etc/redlib.conf";
    ExecStart = "${pkgs.redlib}/bin/redlib -a ${listenAddress} -p ${port}";
    DeviceAllow = "";
    LockPersonality = "yes";
    MemoryDenyWriteExecute = "yes";
    PrivateDevices = "yes";
    ProcSubset = "pid";
    ProtectClock = "yes";
    ProtectControlGroups = "yes";
    ProtectHome = "yes";
    ProtectHostname = "yes";
    ProtectKernelLogs = "yes";
    ProtectKernelModules = "yes";
    ProtectKernelTunables = "yes";
    ProtectProc = "invisible";
    RestrictAddressFamilies = "AF_INET AF_INET6";
    RestrictNamespaces = "yes";
    RestrictRealtime = "yes";
    RestrictSUIDSGID = "yes";
    SystemCallArchitectures = "native";
    SystemCallFilter = "@system-service ~@privileged ~@resources";
    UMask = "0077";
  };
}
