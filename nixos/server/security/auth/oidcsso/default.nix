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

  # protectedHosts = builtins.listToAttrs (
  #   lib.lists.forEach (import ../protected-hosts.nix) (vhost: {
  # protectedHosts = builtins.listToAttrs (
  #   lib.lists.forEach cfg.protectedHosts (vhost: {
  # name = vhost.host;
  # value = let
  #   baseUrl = "http://127.0.0.1:${config.portMap.oidcsso}";
  #   queryParams =
  #     "?redirect=https://${vhost.host}"
  #     + (
  #       lib.strings.optionalString
  #       (vhost ? allowed_groups)
  #       "&allowed_groups=${lib.strings.concatStringsSep "," vhost.allowedGroups}"
  #       # )
  #       # + (
  #       #   lib.strings.optionalString
  #       #   (vhost ? allowed_roles)
  #       #   "&allowed_roles=${lib.strings.concatStringsSep "," vhost.allowed_roles}"
  #     );
  # in {

  rbacFile = pkgs.writeTextFile {
    name = "oidcsso-rbac.json";
    text = builtins.toJSON cfg.protectedHosts;
  };

  virtualHosts =
    lib.attrsets.mapAttrs (host: _: let
      baseUrl = "http://127.0.0.1:${config.portMap.oidcsso}";
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
          extraConfig = "internal;";
        };

        "/auth" = {inherit proxyPass;};
        "/auth/callback" = {inherit proxyPass;};
        "/login" = {inherit proxyPass;};

        "@error401".return = "302 https://${host}/login?redirect=${host}";
      };
    })
    cfg.protectedHosts;
  #   })
  # );
  # rbacFile = let
  #   protectedHosts = lib.lists.forEach cfg.protectedHosts (host: {
  #     ${host.host} = {inherit (host) allowedGroups allowedRealmRoles allowedResourceAccess;};
  #   });
  # in
  #   pkgs.writeTextFile {
  #     name = "oidcsso-rbac.json";
  #     text = builtins.toJSON protectedHosts;
  #   };
  # rbacFile = pkgs.writeTextFile {
  #   name = "oidcsso-rbac.json";
  #   text = builtins.toJSON cfg.protectedHosts;
  # };
in {
  imports = [./options.nix];

  services.nginx = {inherit virtualHosts;};
  # services.nginx = {
  #   upstreams = {
  #     "oidcsso_server" = {
  #       servers = {
  #         "127.0.0.1:1337" = {};
  #       };
  #     };
  #   };
  #
  #   virtualHosts = protectedHosts;
  # };

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
