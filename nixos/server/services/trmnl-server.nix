{
  self,
  config,
  pkgs,
  ...
}: let
  stateDir = "/var/lib/trmnl-server";
in {
  services.nginx.virtualHosts."trmnl.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.variables.ports.trmnl-server}";
      proxyWebsockets = true;
    };

    locations."/static" = {
      tryFiles = "${pkgs.trmnl-server}/lib/trmnl-server/$uri =404";
    };
  };

  sops.secrets.trmnl-server = {
    format = "dotenv";
    key = "";
    mode = "0400";
    sopsFile = "${self.lib.secrets.server}/pyload.env";
  };

  systemd.services.trmnl-server = let
    trmnl-server = "${pkgs.trmnl-server}/bin/trmnl-server";
  in {
    description = "BYOS For Trmnl (https://usetrmnl.com)";

    environment = {
      DB_FILE = "${stateDir}/sqlite.db";
    };

    preStart =
      /*
      bash
      */
      ''
        if [ ! -f $DB_FILE ] ; then
          ${trmnl-server} migrate
          ${trmnl-server} createsuperuser --username=admin --email=automation@schwem.io --noinput
        fi
      '';

    serviceConfig = {
      EnvironmentFile = config.sops.secrets.trmnl-server.path;
      ExecStart = "${pkgs.python313Packages.daphne} -b 127.0.0.1 -p ${config.variables.ports.trmnl-server} byos_django.asgi:application";
      Restart = "always";
      RestartSec = "15s";

      WorkingDirectory = stateDir;
      StateDirectory = "trmnl-server";
      RuntimeDirectory = "trmnl-server";
      RuntimeDirectoryMode = "0750";

      PrivateTmp = true;
      DynamicUser = true;
      DevicePolicy = "closed";
      LockPersonality = true;
      # TODO: try to flip below boolean; this config was copied from elsewhere (orig value: false)
      MemoryDenyWriteExecute = false; # onnxruntime/capi/onnxruntime_pybind11_state.so: cannot enable executable stack as shared object requires: Permission Denied
      PrivateUsers = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;
      # TODO: try to change below value; this config was copied from elsewhere (orig value: all)
      ProcSubset = "all"; # Error in cpuinfo: failed to parse processor information from /proc/cpuinfo
      RestrictNamespaces = true;
      RestrictRealtime = true;
      SystemCallArchitectures = "native";
      UMask = "0077";
    };
  };
}
