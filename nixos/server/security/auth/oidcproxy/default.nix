{
  config,
  lib,
  pkgs,
  ...
}: let
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
      # User = "oidcproxy";
      # Group = "oidcproxy";

      SyslogIdentifier = "oidcproxy";
      WorkingDirectory = stateDir;
      StateDirectory = "oidcproxy";
      RuntimeDirectory = "oidcproxy";
      RuntimeDirectoryMode = "0750";

      # ExecStart = "${pkgs.oidcproxy}/bin/oidcproxy -e ${config.sops.secrets.oidcproxy_env.path} -r ${rbacFile.outPath} -d";
      ExecStart = "${lib.getExe pkgs.oidcproxy} -r ${rbacFile} -d";
      Restart = "on-failure";
      RestartSec = 30;

      PrivateTmp = true;
      DynamicUser = true;
      DevicePolicy = "closed";
      LockPersonality = true;
      # TODO: try to flip below boolean; this config was copied from elsewhere (orig value: false)
      MemoryDenyWriteExecute = true; # onnxruntime/capi/onnxruntime_pybind11_state.so: cannot enable executable stack as shared object requires: Permission Denied
      PrivateUsers = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;
      # ProcSubset = "all"; # Error in cpuinfo: failed to parse processor information from /proc/cpuinfo
      RestrictNamespaces = true;
      RestrictRealtime = true;
      SystemCallArchitectures = "native";
      UMask = "0077";

      # Hardening options
      # LockPersonality = "yes";
      # ProtectSystem = "yes";
      # ProtectClock = "yes";
      # ProtectControlGroups = "yes";
      # ProtectHome = "yes";
      # ProtectHostname = "yes";
      # ProtectKernelLogs = "yes";
      # ProtectKernelModules = "yes";
      # ProtectKernelTunables = "yes";
      # ProtectProc = "invisible";
      # RemoveIPC = "yes";
      # RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX AF_NETLINK";
      # RestrictNamespaces = "yes";
      # RestrictRealtime = "yes";
      # NoNewPrivileges = "yes";
      # PrivateDevices = "yes";
      # PrivateTmp = "yes";
    };

    description = "Simple OIDC/OAuth2 proxy";
    wantedBy = ["multi-user.target"];
  };

  sops.secrets.oidcproxy_env = {
    # group = "oidcproxy";
    # owner = "oidcproxy";

    format = "dotenv";
    key = "";
    mode = "0440";
    # path = "${stateDir}/.env";
    # sopsFile = "${self.lib.secrets.server}/oidcproxy.env";
    sopsFile = "${config.variables.secretPaths.server}/oidcproxy.env";
  };

  # systemd.tmpfiles.rules = ["d ${stateDir} 0750 oidcproxy oidcproxy - -"];

  # users = {
  #   groups.oidcproxy = {};
  #   users.oidcproxy = {
  #     group = "oidcproxy";
  #     isSystemUser = true;
  #   };
  # };
}
