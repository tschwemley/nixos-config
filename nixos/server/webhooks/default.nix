{
  config,
  inputs,
  pkgs,
  secretsPath,
  ...
}: let
  pkg = inputs.webhooks.packages.${pkgs.system}.default;
  stateDir = "/var/lib/webhooks";
in {
  systemd.services.webhooks = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "webhooks";
      Group = "webhooks";

      SyslogIdentifier = "webhooks";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/webhooks -e ${config.sops.secrets.webhooks_env.path} -p ${config.portMap.webhooks}";
      Restart = "on-failure";
      RestartSec = 30;

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

    description = "webhooks";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
  };

  sops.secrets.webhooks_env = {
    group = "webhooks";
    owner = "webhooks";

    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = "${secretsPath}/server/webhooks.yaml";
  };

  users = {
    groups.webhooks = {};
    users.webhooks = {
      group = "webhooks";
      isSystemUser = true;
    };
  };
}