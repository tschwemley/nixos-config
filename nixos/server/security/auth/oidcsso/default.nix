{
  config,
  inputs,
  lib,
  pkgs,
  secretsPath,
  ...
}: let
  pkg = inputs.oidcsso.packages.${pkgs.system}.default;
  stateDir = "/var/lib/oidc-sso";

  protectedHosts = builtins.listToAttrs (
    # lib.lists.forEach config.services.oidcsso.protectedHosts (vhost: {
    lib.lists.forEach (import ../protected-hosts.nix) (vhost: {
      name = vhost.host;
      value = let
        baseUrl = "http://127.0.0.1:${config.portMap.oidcsso}";
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
          proxyPass = "http://${baseUrl}$request_uri";
        in {
          "/".extraConfig = "auth_request .auth;";

          ".auth" = {
            proxyPass = "http://${baseUrl}/auth";
            extraConfig = ''
              internal;
            '';
          };

          "/auth" = {inherit proxyPass;};
          "/auth/callback" = {inherit proxyPass;};
          "/login" = {inherit proxyPass;};

          "@error401".proxyPass = "302 http://${baseUrl}/login${queryParams}";
          # "@error401".return = "302 https://auth.schwem.io/login?rd=${vhost.redirect}";
        };
      };
    })
  );
in {
  # imports = [./options.nix];

  services.nginx.virtualHosts = protectedHosts;

  # services.nginx.virtualHosts =
  #   {
  #     "auth.schwem.io".locations = let
  #       proxyPass = "http://127.0.0.1:${config.portMap.oidcsso}$request_uri";
  #     in {
  #       "/auth" = {
  #         inherit proxyPass;
  #       };
  #       "/auth/callback" = {
  #         inherit proxyPass;
  #       };
  #       "/check-token" = {
  #         inherit proxyPass;
  #       };
  #       "/login" = {
  #         inherit proxyPass;
  #       };
  #     };
  #   }
  #   // protectedHosts;

  systemd.services.oidc-sso = let
    afterAndRequires =
      ["nginx.service"]
      ++ (
        if (config.systemd.services ? "keycloak")
        then ["keycloak.service"]
        else []
      );
  in {
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
    # after = [
    #   "network.target"
    #   "keycloak.service"
    # ];
    #
    # requires = [
    #   "keycloak.service"
    #   "nginx.service"
    # ];
    wantedBy = ["multi-user.target"];
  };

  sops.secrets.oidc_sso_env = {
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
