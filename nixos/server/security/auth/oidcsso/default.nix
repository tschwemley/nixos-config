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

  protectedHosts = builtins.listToAttrs (
    lib.lists.forEach (import ../protected-hosts.nix) (vhost: {
      name = vhost.host;
      value = let
        baseUrl = "http://oidcsso_server";
        queryParams =
          "?redirect=${vhost.redirect}"
          + (
            lib.strings.optionalString
            (vhost ? allowed_groups)
            "&allowed_groups=${lib.strings.concatStringsSep "," vhost.allowed_groups}"
          )
          + (
            lib.strings.optionalString
            (vhost ? allowed_roles)
            "&allowed_roles=${lib.strings.concatStringsSep "," vhost.allowed_roles}"
          );
      in {
        extraConfig = ''
          error_page 401 = @error401;
        '';

        locations = let
          proxyPass = "${baseUrl}$request_uri";
        in {
          "/".extraConfig = "auth_request .auth;";

          ".auth" = {
            proxyPass = "${baseUrl}/auth";
            # proxyPass = "http://oidcsso_server/auth";
            extraConfig = ''
              internal;
            '';
          };

          "/auth" = {inherit proxyPass;};
          "/auth/callback" = {inherit proxyPass;};
          "/login" = {inherit proxyPass;};

          "@error401".proxyPass = "${baseUrl}/login${queryParams}";
          # TODO :I think this actually needs to point to ${vhost.host}/login (if proxypass doesn't work)
          # "@error401".return = "302 http://oidcsso_server/login${queryParams}";
        };
      };
    })
  );
in {
  # imports = [./options.nix];

  services.nginx = {
    upstreams = {
      "oidcsso_server" = {
        servers = {
          "127.0.0.1:1337" = {};
        };
      };
    };

    virtualHosts = protectedHosts;
  };

  systemd.services.oidcsso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidcsso";
      Group = "oidcsso";

      SyslogIdentifier = "oidcsso";
      WorkingDirectory = stateDir;

      ExecStart = "${pkg}/bin/oidcsso -e ${config.sops.secrets.oidcsso_env.path}";
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
    # after = afterAndRequires;
    # requires = afterAndRequires;
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
