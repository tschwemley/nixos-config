{
  lib,
  pkgs,
  enableDiscovery ? false,
  ...
}: let
  devices = {
    charizard = {
      id = "7VRFMPP-LVHA2JL-UY43A5S-4OORFB4-VSW3HQS-TX2L74G-2XNQ2MM-E77I7QO";
    };
    moltres = {
      id = "7VRFMPP-LVHA2JL-UY43A5S-4OORFB4-VSW3HQS-TX2L74G-2XNQ2MM-E77I7QO";
    };
  };
in rec {
  # see: https://search.nixos.org/options?channel=23.11&show=services.syncthing.settings.options&from=0&size=50&sort=relevance&type=packages&query=syncthing
  services = {
    syncthing = {
      enable = true;

      # TODO: fill out if necessary
      # tls
      cert = null;
      key = null;

      dataDir = "/var/lib/syncthing";

      # opens TCP/UDP 22000 for transfers and UDP 21027 for discovery
      openDefaultPorts = true;

      # relay = {};
      settings = {
        devices = {};
        #folders = {};
        options = {
          urAccepted = -1; # don't allow usage data reporting
        };
      };
    };
  };

  systemd.services.syncthing-discovery = lib.mkIf enableDiscovery {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      ExecStart = "${pkgs.syncthing-discovery}/bin/stdiscosrv -http";
      WorkingDirectory = "${services.syncthing.dataDir}";
      StateDirectory = ".discovery";
      SyslogIdentifier = "stdiscosrv";
    };

    unitConfig = {
      After = "network.target";
      Description = "Syncthing discovery service";
    };

    wantedBy = ["multi-user.target"];
  };
}
