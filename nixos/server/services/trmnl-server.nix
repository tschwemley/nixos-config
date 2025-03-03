{
  self,
  config,
  pkgs,
  ...
}: let
  bindAddr = "127.0.0.1";
  port = config.variables.ports.trmnl-server;
  stateDir = "/var/lib/trmnl-server";
in {
  services.nginx.virtualHosts."trmnl.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.variables.ports.trmnl-server}";
      proxyWebsockets = true;
    };

    # locations."/static/" = {
    locations."/static" = {
      tryFiles = "${pkgs.trmnl-server}/lib/static/$uri =404";
    };
  };

  sops.secrets.trmnl-server = {
    format = "dotenv";
    key = "";
    mode = "0400";
    sopsFile = "${self.lib.secrets.server}/trmnl-server.env";
  };

  systemd.services.trmnl-server = {
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
          ${pkgs.trmnl-server}/bin/trmnl-server-init --username=admin --email=automation@schwem.io --noinput
        fi
      '';

    serviceConfig = {
      EnvironmentFile = config.sops.secrets.trmnl-server.path;
      ExecStart = "${pkgs.trmnl-server}/bin/trmnl-server-run -b ${bindAddr} -p ${port}";
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
