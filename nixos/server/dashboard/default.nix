{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkg = inputs.dashboard.packages.${pkgs.system}.default;
  stateDir = "/var/lib/dashboard";
in
{
  services.nginx.virtualHosts."dash.schwem.io" = {
    extraConfig = ''
      error_page 401 = @error401;
    '';

    locations =
      let
        baseUrl = "http://127.0.0.1:${config.portMap.dashboard}";
      in
      {
        "/" = {
          proxyPass = baseUrl;
          extraConfig = ''
            auth_request .auth;
          '';
        };

        ".auth" = {
          proxyPass = "${baseUrl}/auth";
          extraConfig = ''
            internal;
          '';
        };

        "@error401".return = "302 https://auth.schwem.io/login?rd=https://dash.schwem.io";
      };
  };

  systemd.services.dashboard = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "dashboard";
      Group = "dashboard";

      SyslogIdentifier = "dashboard";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/dashboard -e ${config.sops.secrets.dashboard_env.path} -p ${config.portMap.dashboard}";

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

    description = "dashboard";
    after = [
      "network.target"
      "keycloak.service"
    ];
    requires = [
      "keycloak.service"
      "nginx.service"
    ];
    wantedBy = [ "multi-user.target" ];
  };

  sops.secrets.dashboard_env = {
    group = "dashboard";
    owner = "dashboard";
    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = ./secrets.yaml;
  };

  users = {
    groups.dashboard = { };
    users.dashboard = {
      group = "dashboard";
      isSystemUser = true;
    };
  };
}
