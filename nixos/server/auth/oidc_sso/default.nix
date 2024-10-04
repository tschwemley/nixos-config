{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkg = inputs.oidcsso.packages.${pkgs.system}.default;
  stateDir = "/var/lib/oidc-sso";
in
{
  services.nginx.virtualHosts."auth.schwem.io".locations =
    let
      proxyPass = "http://127.0.0.1:${config.portMap.oidc-sso}$request_uri";
    in
    {
      "/auth" = {
        inherit proxyPass;
      };
      "/auth/callback" = {
        inherit proxyPass;
      };
      "/check-token" = {
        inherit proxyPass;
      };
      "/login" = {
        inherit proxyPass;
      };
    };

  systemd.services.oidc-sso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidc-sso";
      Group = "oidc-sso";

      SyslogIdentifier = "oidc-sso";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/oidcsso -e ${config.sops.secrets.oidc_sso_env.path}";

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
    requires = [
      "keycloak.service"
      "nginx.service"
    ];
    wantedBy = [ "multi-user.target" ];
  };

  sops.secrets.oidc_sso_env = {
    group = "oidc-sso";
    owner = "oidc-sso";
    path = "${stateDir}/.env";
    mode = "0440";
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
