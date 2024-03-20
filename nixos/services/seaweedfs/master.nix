{
  config,
  pkgs,
  utils,
  ...
}: let
  ip = "${config.networking.hostName}.wyvern-map.ts.net";
  bindIP = "127.0.0.1";
in {
  systemd.services.seaweedfs-master = {
    after = [
      "network.target"
    ];
    description = "SeaweedFS Server";
    wantedBy = [
      "multi-user.target"
    ];
    environment = {};
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.seaweedfs}/bin/weed"
        "master"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-mdir=master"
        "-volumePreallocate"
        "-volumeSizeLimitMB=8192"
      ];
      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-master";
    };
  };
}
