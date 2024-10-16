{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pkg = inputs.oidcsso.packages.${pkgs.system}.default;
  stateDir = "/var/lib/oidc-sso";

  protectedHosts = builtins.listToAttrs (
    lib.lists.forEach config.services.oidcsso.protectedHosts (vhost: {
      name = vhost.host;
      value = {
        extraConfig = ''
          error_page 401 = @error401;
        '';

        locations = {
          "/".extraConfig = "auth_request .auth;";

          ".auth" = {
            proxyPass = "http://articuno:${config.portMap.oidcsso}/auth";
            extraConfig = ''
              internal;
            '';
          };

          "@error401".return = "302 https://auth.schwem.io/login?rd=${vhost.redirect}";
        };
      };
    })
  );
in
{
  imports = [ ./options.nix ];

  services.nginx.virtualHosts = {
    "auth.schwem.io".locations =
      let
        proxyPass = "http://127.0.0.1:${config.portMap.oidcsso}$request_uri";
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
  } // protectedHosts;

  systemd.services.oidc-sso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidcsso";
      Group = "oidcsso";

      SyslogIdentifier = "oidcsso";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/oidcsso -e ${config.sops.secrets.oidc_sso_env.path}";
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

    description = "Simple OIDC/OAuth2 proxy for auth code flow.";
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

  sops.secrets.oidc_sso_env = {
    group = "oidcsso";
    owner = "oidcsso";
    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = ./env.yaml;
  };

  users = {
    groups.oidcsso = { };
    users.oidcsso = {
      group = "oidcsso";
      isSystemUser = true;
    };
  };
}
