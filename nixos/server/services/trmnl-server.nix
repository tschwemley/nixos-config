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
  /*
  upstream backend {
      server app:8000;
  }

  server {
      listen 80 default_server;
      server_name trmnl.dev;
      location / {
          try_files $uri @proxy_to_app;
      }

      location /static {
          alias /src/static;
      }

      location @proxy_to_app {
          proxy_pass http://backend;

          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";

          proxy_redirect off;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Proto $scheme;
      }
  }
  */

  services.nginx.virtualHosts."trmnl.schwem.io" = {
    locations = {
      "/" = {
        tryFiles = "$uri @proxy_to_app";
        # proxyPass = "http://127.0.0.1:${config.variables.ports.trmnl-server}";
        # proxyWebsockets = true;
      };

      # locations."/static/" = {
      "/static" = {
        alias = "${pkgs.trmnl-server}/lib/static";
        # tryFiles = "${pkgs.trmnl-server}/lib/static/$uri =404";
      };

      "@proxy_to_app" = {
        proxyPass = "http://127.0.0.1:${config.variables.ports.trmnl-server}";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";

          proxy_redirect off;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
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
