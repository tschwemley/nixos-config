{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkg = inputs.server-oidc-sso.packages.${pkgs.system}.default;
  runDir = "/var/lib/oidc-sso";
in
{
  systemd.services.oidc-sso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidc-sso";
      Group = "oidc-sso";

      ExecStart = "${pkg}/bin/oidcsso -debug";

      EnvironmentFile = config.sops.secrets.oidc_sso_env.path;
      # StateDirectory = runDir;
      SyslogIdentifier = "oidc-sso";
      WorkingDirectory = runDir;

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

    description = "oidc-sso";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  };

  sops.secrets.oidc_sso_env = {
    group = "oidc-sso";
    owner = "oidc-sso";
    path = "${runDir}/.env";
    sopsFile = ./secrets.yaml;
  };

  users = {
    groups.oidc-sso = { };
    users.oidc-sso = {
      group = "oidc-sso";
      isSystemUser = true;
    };
  };
}
