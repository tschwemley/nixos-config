{pkgs, ...}: let
  stateDir = "netbird";
in {
  systemd.services.netbird-signal = {
    description = "NetBird signal service";
    serviceConfig = {
      ExecStart = "${pkgs.netbird}/bin/netbird-signal run --port=10000";
      Restart = "always";
      RuntimeDirectory = stateDir;
      StateDirectory = stateDir;
      StateDirectoryMode = "0700";
      WorkingDirectory = "/var/lib/${stateDir}";
    };
  };
}
