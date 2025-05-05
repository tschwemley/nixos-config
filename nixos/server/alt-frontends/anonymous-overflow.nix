{
  self,
  config,
  pkgs,
  ...
}: let
  pkg = self.inputs.anonymous-overflow.packages.${pkgs.system}.default;

  runDir = "/var/run/anonymous-overflow";
  stateDir = "/var/lib/anonymous-overflow";
in {
  services.nginx = {
    virtualHosts."so.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${self.lib.port-map.anonymous-overflow}";
      };
    };
  };

  systemd = {
    services.anonymous-overflow = {
      description = "Alternative front end for stack overflow";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];

      environment = {
        APP_URL = "https://so.schwem.io";
        PORT = self.lib.port-map.anonymous-overflow;
      };

      path = [pkg];

      serviceConfig = {
        Type = "simple";
        EnvironmentFile = config.sops.secrets.anonymous-overflow.path;
        ExecStart = "${pkg}/bin/anonymousoverflow";

        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateMounts = "yes";
        PrivateTmp = "yes";
        ProtectHome = "yes";
        ProtectHostname = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        ReadWritePaths = [
          runDir
          stateDir
        ];
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_INET"
          "AF_INET6"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        WorkingDirectory = runDir;
      };
    };

    tmpfiles.rules = [
      "d ${runDir} 0750 anonymous-overflow anonymous-overflow - -"
      "L ${runDir}/public - - - - ${pkg}/share/public"
      "L ${runDir}/templates - - - - ${pkg}/share/templates"
      "d ${stateDir} 0755 anonymous-overflow anonymous-overflow - -"
    ];
  };

  sops.secrets.anonymous-overfow = {
    format = "dotenv";
    key = "";
    owner = "anonymous-overflow";

    mode = "0400";
    # path = "${stateDir}/.env";
    sopsFile = "${config.variables.secretPaths.server}/anonymous-overflow.env";
  };

  users = {
    groups.anonymous-overflow = {};
    users.anonymous-overflow = {
      isSystemUser = true;
      group = "anonymous-overflow";
      description = "anonymous overflow service user";
      home = stateDir;
    };
  };
}
