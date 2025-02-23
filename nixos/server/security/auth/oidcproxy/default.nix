{
  self,
  config,
  # inputs,
  lib,
  pkgs,
  ...
}: let
  # pkg = inputs.oidcproxy.packages.${pkgs.system}.default;
  stateDir = "/var/lib/oidcproxy";

  cfg = config.services.oidcproxy;

  rbacFile = pkgs.writeTextFile {
    name = "oidcproxy-rbac.json";
    text = builtins.toJSON cfg.protectedHosts;
  };

  virtualHosts =
    lib.attrsets.mapAttrs (host: info: let
      baseUrl = "http://oidcproxy_server";
    in {
      extraConfig = ''
        error_page 401 = @error401;
      '';

      locations = let
        proxyPass = "${baseUrl}$request_uri";
        baseLocations = {
          ".auth" = {
            proxyPass = "${baseUrl}/auth";
            extraConfig = "internal;";
          };

          "/auth" = {inherit proxyPass;};
          "/auth/callback" = {inherit proxyPass;};
          "/login" = {inherit proxyPass;};

          "@error401".return = "302 https://${host}/login?redirect=${host}";

          "/" = {
            proxyPass = info.upstream;
            extraConfig = "auth_request .auth;";
          };
        };

        unprotectedLocations = builtins.listToAttrs (builtins.map (path: {
            name = path;
            value = {
              proxyPass = "${info.upstream}$request_uri";
              extraConfig = "auth_request off;";
            };
          })
          info.unprotectedPaths);
      in
        unprotectedLocations // baseLocations;
    })
    cfg.protectedHosts;
in {
  imports = [./options.nix];

  services.nginx = {
    inherit virtualHosts;

    upstreams = {
      "oidcproxy_server" = {
        servers = {
          "127.0.0.1:1337" = {};
        };
      };
    };
  };

  systemd.services.oidcproxy = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidcproxy";
      Group = "oidcproxy";

      SyslogIdentifier = "oidcproxy";
      WorkingDirectory = stateDir;

      ExecStart = "${pkgs.oidcproxy}/bin/oidcproxy -e ${config.sops.secrets.oidcproxy_env.path} -r ${rbacFile.outPath} -d";
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

  sops.secrets.oidcproxy_env = {
    group = "oidcproxy";
    owner = "oidcproxy";
    path = "${stateDir}/.env";
    mode = "0440";
    sopsFile = "${self.lib.secrets.server}/oidcproxy.yaml";
  };

  users = {
    groups.oidcproxy = {};
    users.oidcproxy = {
      group = "oidcproxy";
      isSystemUser = true;
    };
  };
}
