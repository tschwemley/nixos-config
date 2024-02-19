{pkgs, ...}: let
  stateDir = "netbird";
in {
  systemd.services.netbird-signal = {
    description = "NetBird signal service";
    before = "netbird-management.service";
    serviceConfig = {
      ExecStart = "${pkgs.netbird}/bin/netbird-signal service run";
      Restart = "always";
      RuntimeDirectory = stateDir;
      StateDirectory = stateDir;
      StateDirectoryMode = "0700";
      WorkingDirectory = "/var/lib/signal/${stateDir}";
    };
  };
}
