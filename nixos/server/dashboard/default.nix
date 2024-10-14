{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkg = inputs.dashboard.packages.${pkgs.system}.default;
  stateDir = "/var/lib/dashboard";
  staticPath = "${inputs.dashboard.packages.${pkgs.system}.default}/bin/web/static";
in
{
  # services.nginx.virtualHosts."dash.schwem.io" = {
  services.nginx.virtualHosts."schwem.io" = {
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

        # "/robots.txt".proxyPass = ".request";

        ".auth" = {
          proxyPass = "http://127.0.0.1:${config.portMap.oidcsso}/auth";
          extraConfig = ''
            internal;
          '';
        };

        "@error401".return = "302 https://auth.schwem.io/login?rd=https://schwem.io";
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

      ExecStart = "${pkg}/bin/dashboard -e ${config.sops.secrets.dashboard_env.path} -p ${config.portMap.dashboard} -static-path ${staticPath}";
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

    key = "oidc_sso_env";
    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = ../auth/oidc_sso/env.yaml; # dashboard env only contains oidc values (cookie/provider info) for now
  };

  users = {
    groups.dashboard = { };
    users.dashboard = {
      group = "dashboard";
      isSystemUser = true;
    };
  };
}
