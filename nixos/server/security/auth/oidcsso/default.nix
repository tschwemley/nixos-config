{
  config,
  inputs,
  lib,
  pkgs,
  secretsPath,
  ...
}: let
  pkg = inputs.oidcsso.packages.${pkgs.system}.default;
  stateDir = "/var/lib/oidcsso";

  cfg = config.services.oidcsso;

  rbacFile = pkgs.writeTextFile {
    name = "oidcsso-rbac.json";
    text = builtins.toJSON cfg.protectedHosts;
  };

  virtualHosts =
    lib.attrsets.mapAttrs (host: info: let
      baseUrl = "http://oidcsso_server";
    in {
      extraConfig = ''
        error_page 401 = @error401;
      '';

      locations = let
        proxyPass = "${baseUrl}$request_uri";
      in {
        "/" = {
          proxyPass = info.upstream;
          extraConfig = "auth_request .auth;";
        };

        ".auth" = {
          proxyPass = "${baseUrl}/auth";
          extraConfig = "internal;";
        };

        "/auth" = {inherit proxyPass;};
        "/auth/callback" = {inherit proxyPass;};
        "/login" = {inherit proxyPass;};

        "@error401".return = "302 https://${host}/login?redirect=${host}";
      };
    })
    cfg.protectedHosts;
in {
  imports = [./options.nix];

  services.nginx = {
    inherit virtualHosts;

    upstreams = {
      "oidcsso_server" = {
        servers = {
          "127.0.0.1:1337" = {};
        };
      };
    };
  };

  systemd.services.oidcsso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidcsso";
      Group = "oidcsso";

      SyslogIdentifier = "oidcsso";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/oidcsso -e ${config.sops.secrets.oidcsso_env.path} -r ${rbacFile.outPath}";
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

    description = "Simple OIDC/OAuth2 proxy";
    wantedBy = ["multi-user.target"];
  };

  sops.secrets.oidcsso_env = {
    group = "oidcsso";
    owner = "oidcsso";
    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = "${secretsPath}/server/oidcsso.yaml";
  };

  users = {
    groups.oidcsso = {};
    users.oidcsso = {
      group = "oidcsso";
      isSystemUser = true;
    };
  };
}
