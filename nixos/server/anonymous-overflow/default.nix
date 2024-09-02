{
  self,
  lib,
  ...
}: let
  pkg = self.packages.anonymous-overflow;

  runDir = "/var/run/anonymous-overflow";
  stateDir = "/var/lib/anonymous-overflow";

  jwtSecret = let
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?";
  in
    builtins.genString (_: builtins.substring (lib.random 0 (builtins.stringLength chars - 1)) 1 chars) 32;
in {
  users.users.anonymous-overflow = {
    group = "anonymous-overflow";
    description = "anonymous overflow service user";
    home = stateDir;
  };

  systemd.tmpfiles.rules = [
    "d ${stateDir} 0755 chrony chrony - -"
  ];

  systemd.services.anonymous-overflow = {
    description = "Alternative front end for stack overflow";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    environment = {
      APP_URL = "https://so.schwem.io";
      JWT_SIGNING_SECRET = jwtSecret;
    };

    path = [pkg];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkg}/anonymous-overflow";

      LockPersonality = true;
      NoNewPrivileges = true;
      PrivateMounts = "yes";
      PrivateTmp = "yes";
      ProtectHome = "yes";
      ProtectHostname = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectSystem = "strict";
      ReadWritePaths = [runDir stateDir];
      RestrictAddressFamilies = ["AF_UNIX" "AF_INET" "AF_INET6"];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      # SystemCallFilter = "@system-service @clock";

      # KeyringMode = "private";
      # MemoryDenyWriteExecute = true;
      # ProtectControlGroups = true;
      # RemoveIPC = true;
      # SystemCallArchitectures = "native";
    };
  };
}
